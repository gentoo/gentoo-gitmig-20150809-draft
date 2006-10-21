# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-5.1.13_alpha20061018.ebuild,v 1.1 2006/10/21 14:34:16 chtekk Exp $

# Leave this empty
MYSQL_VERSION_ID=""
MYSQL_RERELEASE=""
# Set the patchset revision to use, must be either empty or a decimal number
MYSQL_PATCHSET_REV=""

inherit mysql

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

src_test() {
	cd "${S}"
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	eerror
	eerror "Tests aren't ready yet!"
	eerror
}
