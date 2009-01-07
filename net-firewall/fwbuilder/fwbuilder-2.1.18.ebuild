# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-2.1.18.ebuild,v 1.6 2009/01/07 20:22:16 ranger Exp $

EAPI=2

inherit eutils qt3 autotools

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="nls"

DEPEND="~net-libs/libfwbuilder-${PV}
	nls? ( >=sys-devel/gettext-0.11.4 )
	~dev-java/antlr-2.7.7[cxx]
	>=dev-libs/libxslt-1.0.7"

src_configure() {
	# we'll use our eqmake instead of bundled script to process qmake files
	sed -i -e 's:^. ./runqmake.sh$:echo:' configure \
		|| die "sed configure failed"
	# prevent install script from automatically stripping binaries - let portage do that
	sed -i -e 's/s) stripcmd="$stripprog"$/s)/' install.sh \
		|| die "sed install.sh failed"
	# documentation will be installed manually using dodoc & doman
	rm -f doc/doc.pro
	sed -i -e '/^SUBDIRS = po src doc/s/ doc//' fwbuilder2.pro \
		|| die "sed fwbuilder2.pro failed"

	econf $(use_enable nls) || die "configure failed"

	# use eqmake to generate Makefiles
	eqmake3 fwbuilder2.pro
	for subdir in po src src/res src/tools src/gui \
			src/fwblookup src/fwbedit src/ipt src/pflib \
			src/pf src/ipf src/ipfw src/parsers; do
		eqmake3 "${subdir}/${subdir##*/}.pro" -o ${subdir}/Makefile
	done
}

src_install() {
	emake install DDIR="${D}" || die "install failed"

	cd doc
	dodoc AUTHORS ChangeLog Credits README* \
		FWBuilder-Routing-LICENSE.txt PatchAcceptancePolicy.txt
	newdoc ReleaseNotes_${PV}.txt ReleaseNotes
	doman fwb*.1
	cd ..

	newicon src/gui/icons/firewall_64.png ${PN}.png
	make_desktop_entry fwbuilder "Firewall Builder" ${PN} "System;Security;Qt"
}

pkg_postinst() {
	echo
	elog "You need to emerge sys-apps/iproute2 on the machine"
	elog "that will run the firewall script."
	echo
}
