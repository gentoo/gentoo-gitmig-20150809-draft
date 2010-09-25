# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/checkpassword/checkpassword-0.ebuild,v 1.6 2010/09/25 13:40:42 maekke Exp $

DESCRIPTION="Virtual for checkpassword compatible applications"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| (
	net-mail/checkpassword
	net-mail/checkpassword-pam
	net-mail/checkpw
	net-mail/cmd5checkpw
	net-mail/vmailmgr
	net-mail/vpopmail
	mail-mta/qmail-ldap
)"
