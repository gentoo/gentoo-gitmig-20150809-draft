# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-javamail/ant-javamail-1.7.1.ebuild,v 1.2 2008/12/20 16:21:40 nixnut Exp $

EAPI=1

ANT_TASK_DEPNAME="--virtual javamail"

inherit ant-tasks

KEYWORDS="~amd64 ppc ~ppc64 ~x86"

DEPEND="java-virtuals/javamail
	dev-java/sun-jaf"
RDEPEND="${DEPEND}"

src_unpack() {
	ant-tasks_src_unpack all
	java-pkg_jar-from sun-jaf
}
