# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/WASH/WASH-2.0.5.ebuild,v 1.1 2004/10/26 17:47:26 kosmikus Exp $

# the installation bundle is called WashNGo
MY_P="WashNGo"
MY_PV=${MY_P}-${PV}

DESCRIPTION="WASH is a family of embedded domain-specific languages for programming Web applications"
HOMEPAGE="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/"
SRC_URI="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/${MY_PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc postgres"

DEPEND=">=virtual/ghc-6.2
	postgres? ( dev-haskell/c2hs
		>=dev-db/postgresql-7.4.3 )"

# RDEPEND: c2hs needed?

S=${WORKDIR}/${MY_PV}

src_compile() {
	local myopts
	myopts="${myopts} `use_enable postgres dbconnect`"
	myopts="${myopts} `use_enable doc build-docs`"
	# determine ghc library directory
	ghc_version=`best_version virtual/ghc | sed "s:.*/::"`
	test -n ${ghc_version} && ghclibdir="/usr/lib/${ghc_version}"
	test -n ${ghclibdir} || ghclibdir="/usr/lib"
	test -n ${ghclibdir} && myopts="${myopts} --libdir=${D}${ghclibdir}"
	./configure \
		--prefix="${D}usr" \
		--host=${CHOST} \
		${myopts} \
		--enable-register-package="${S}/${MY_PV}.conf" \
			|| die "configure failed"
	make depend || die "make depend failed"
	make all || die "make all failed"
}

src_install() {
	mkdir -p ${D}${ghclibdir}
	echo "[]" > ${S}/${MY_PV}.conf
	make install || die "make install failed"
	# fix references to D in temporary package configuration file
	cat ${S}/${MY_PV}.conf | sed "s:${D}::" \
		> ${D}${ghclibdir}/${MY_PV}.conf

	dodoc README
	if use doc; then
		cp -r Examples ${D}/usr/share/doc/${PF}
		cd doc
		dohtml -r *
	fi
}

pkg_postinst() {
	# packages: WASH/WASHHTML cgi/WASH-CGI dbconnect/DBCONNECT
	#    Utility/Utility Mail/WASHMail
	register_ghc_package Utility
	register_ghc_package WASHHTML
	register_ghc_package WASHMail
	register_ghc_package WASH-CGI
	register_ghc_package WASH
	use postgres && register_ghc_package DBCONNECT
}

pkg_postrm() {
	# check if another version is still there
	has_version "<${CATEGORY}/${PF}" \
		|| has_version ">${CATEGORY}/${PF}" \
		|| unregister_ghc_packages
}

register_ghc_package() {
	einfo "Registering $1 package"
	/usr/bin/ghc-pkg -f ${ghclibdir}/${MY_PV}.conf -s $1 \
		| /usr/bin/ghc-pkg -u --auto-ghci-libs
}

unregister_ghc_packages() {
	unregister_ghc_package DBCONNECT
	unregister_ghc_package WASH
	unregister_ghc_package WASH-CGI
	unregister_ghc_package WASHMail
	unregister_ghc_package WASHHTML
	unregister_ghc_package Utility
}

unregister_ghc_package() {
	einfo "Unregistering $1 package (warnings are safe to ignore)"
	/usr/sbin/ghc-pkg -r $1
}
