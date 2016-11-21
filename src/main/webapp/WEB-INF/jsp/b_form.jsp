<%@ page session="true"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.stylease.entities.Key" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<t:page>
    <jsp:attribute name="title">Welcome!</jsp:attribute>
    <jsp:body>
        <div class="jumbotron" id="welcome">
			<div class="row">
				<div class="col-md-2">
					<h3>Boards</h3>
					Boards go here
				</div>
				<div class="col-md-10 fill">
					<h3>${board_action} Board</h3>
					<form method="POST">
						<div class="form-group">
							<label for="txtBoardName">Name:</label>
							<input type="text" class="form-control" id="txtBoardName" name="boardName" value="${param.boardName}"/>
							
							<label for="selUsers">Users:</label>
							<select id="selUsers" name="users" class="form-control" size="5">
								<c:forEach var="uentry" items="${sessionScope.usertbl}">
									<option value="${uentry.key}">${ uentry.value.getName() }</option>
								</c:forEach>
							</select>
							
							<label for="txtUser">Add user:</label>
							<input type="text" class="form-control" id="txtUser" name="user" />
							
							<fieldset class="form-group">
								<legend>Permissions</legend>
								<div class="form-check">
									<label for="chkCanRead">
										<input type="checkbox" id="chkCanRead" name="can_read" class="form-check-input"/>
										Can Read
									</label>
								</div>
								
								<div class="form-check">
									<label for="chkCanWrite">
										<input type="checkbox" id="chkCanWrite" name="can_write" class="form-check-input"/>
										Can Write
									</label>
								</div>
								
								<div class="form-check">
									<label for="chkCanInvite">
										<input type="checkbox" id="chkCanInvite" name="invite_users" class="form-check-input"/>
										Can invite other users
									</label>
								</div>
								
								<div class="form-check">
									<label for="chkAdmin">
										<input type="checkbox" id="chkAdmin" name="administer" class="form-check-input"/>
										Board Administrator
									</label>
								</div>
							
								<button id="btnAddUser" name="userop" type="submit" value="${userop_add}" class="btn btn-success">Add User</button>
								<button id="btnModUser" name="userop" type="submit" value="${userop_mod}" class="btn btn-info" style="display:none;">Modify Permissions</button>
							</fieldset>
							
							<div class="form-check">
								<label for="chkPublic">
									<input type="checkbox" id="chkPublic" name="ispublic" class="form-check-input" ${!empty param.ispublic ? 'checked' : ''}/>
									Public board (anyone can view)
								</label>
							</div>
						</div>
						
						<button name="saveboard" type="submit" value="${submit_action}" class="btn btn-primary">${submit_action}</button>
						
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			</div>            
        </div>
        <script type="text/javascript">
        	var perms = {
        		<c:forEach var="entry" items="${sessionScope.userkeys}">
        			${entry.key}: {
        				"can_read": ${entry.value.canRead()},
        				"can_write": ${entry.value.canWrite()},
        				"invite_users": ${entry.value.canInvite()},
        				"administer": ${entry.value.isAdmin()}
        			},
        		</c:forEach>
        	};
        	
        	var userop_add = "${userop_add}";
        	var userop_rem = "${userop_rem}";
        </script>
        <script src="/resources/js/b_form.js"></script>
    </jsp:body>
</t:page>
