# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.22-r1.ebuild,v 1.2 2007/01/12 17:58:32 chtekk Exp $

MY_EXTRAS_VER="20070105"
SERVER_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/mysql-${PV//_/-}.tar.gz"

inherit mysql

# REMEMBER: also update eclass/mysql*.eclass before committing!
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

src_test() {
	cd "${S}"
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
		sed -i -e "s|3306|3307|g" mysql-test-run.pl

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
