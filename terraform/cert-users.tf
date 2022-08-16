# Creating group administrators
resource "aws_iam_group" "certManagerIAMGroup" {
    name = "certManagerIAMGroup"
}

resource "aws_iam_policy_attachment" "certManagerIAMGroup-attach" {
    name = "certManagerIAMGroup-attach"
    groups = ["${aws_iam_group.certManagerIAMGroup.name}"]
    policy_arn = "${aws_iam_policy.certManagerPolicy.arn}"
}

# create users
resource "aws_iam_user" "certManagerIAMUser" {
    name = "certManagerIAMUser"
}

# add users to group
resource "aws_iam_group_membership" "certManagerIAMGroup" {
    name = "certManagerIAMGroup"
    users = [
        "${aws_iam_user.certManagerIAMUser.name}",
    ]
    group = "${aws_iam_group.certManagerIAMGroup.name}"
}