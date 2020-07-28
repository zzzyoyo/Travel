package domain;

public class InvitedUser extends User {
    private int invitationState;
    private int invitationId;

    public int getInvitationId() {
        return invitationId;
    }

    public void setInvitationId(int invitationId) {
        this.invitationId = invitationId;
    }

    public int getInvitationState() {
        return invitationState;
    }

    public void setInvitationState(int invitationState) {
        this.invitationState = invitationState;
    }
}
