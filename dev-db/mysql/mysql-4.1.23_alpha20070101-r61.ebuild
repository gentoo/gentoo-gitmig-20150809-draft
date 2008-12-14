# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.23_alpha20070101-r61.ebuild,v 1.5 2008/12/14 20:17:13 klausman Exp $

MY_EXTRAS_VER="latest"
SERVER_URI="mirror://gentoo/MySQL-${PV%.*}/mysql-${PV//_alpha/-bk-}.tar.bz2"

inherit mysql
# only to make repoman happy. it is really set in the eclass
IUSE="$IUSE"

# REMEMBER: also update eclass/mysql*.eclass before committing!
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

src_test() {
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! use "minimal" ; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		local testopts="--force"

		# sandbox makes ndbd zombie
		hasq "sandbox" ${FEATURES} && testopts="${testopts} --skip-ndb"

		addpredict /this-dir-does-not-exist/t9.MYI

		cd mysql-test

		# from Makefile.am:
		retstatus=1
		./mysql-test-run.pl ${testopts} \
		&& ./mysql-test-run.pl ${testopts} --ps-protocol \
		&& retstatus=0

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
