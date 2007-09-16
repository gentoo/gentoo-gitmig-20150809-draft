# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/checkpassword/checkpassword-0.ebuild,v 1.1 2007/09/16 12:48:33 hollow Exp $

DESCRIPTION="Virtual for checkpassword compatible applications"
HOMEPAGE="http://cr.yp.to/checkpwd.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

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
