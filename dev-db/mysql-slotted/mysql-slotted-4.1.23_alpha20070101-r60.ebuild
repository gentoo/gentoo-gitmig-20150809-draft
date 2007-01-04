# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-slotted/mysql-slotted-4.1.23_alpha20070101-r60.ebuild,v 1.2 2007/01/04 20:53:15 vivo Exp $

MY_EXTRAS_VER="latest"
SERVER_URI="mirror://gentoo/MySQL-${PV%.*}/mysql-${PV//_alpha/-bk-}.tar.bz2"

inherit mysql

#REMEMBER!!!: update also eclass/mysql*.eclass prior to commit
KEYWORDS="~amd64 ~x86"

src_test() {
	cd "${S}"
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq "minimal" ; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		cd mysql-test
		sed -i -e "s|PORT=3306|PORT=3307|g" mysql-test-run
		./mysql-test-run
		retstatus=$?

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
