# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/eagle/eagle-4.16_p1.ebuild,v 1.1 2006/12/06 02:34:38 nixphoeni Exp $

inherit eutils

DESCRIPTION="EAGLE Layout Editor"
HOMEPAGE="http://www.cadsoft.de"

KEYWORDS="~x86"
IUSE="linguas_de doc"
LICENSE="cadsoft"
RESTRICT="strip"
SLOT="0"

MY_PV=${PV/_p/r}
MANDOC="cadsoft_eagle_manual"
MANVER="2006.04.03"

SRC_URI="linguas_de? ( ftp://ftp.cadsoft.de/pub/program/${MY_PV}/${PN}-lin-ger-${MY_PV}.tgz
			doc? ( mirror://gentoo/${MANDOC}-ger-${MANVER}.pdf ) )
	!linguas_de? ( ftp://ftp.cadsoft.de/pub/program/${MY_PV}/${PN}-lin-eng-${MY_PV}.tgz
			doc? ( mirror://gentoo/${MANDOC}-eng-${MANVER}.pdf ) )"

RDEPEND="sys-libs/glibc
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"

INSTALLDIR="/opt/eagle"
case "${LINGUAS}" in
	de)
		MY_LANG="ger";;
	*)
		MY_LANG="eng";;
esac
MANFILE=${MANDOC}-${MY_LANG}-${MANVER}.pdf
MY_P=${PN}-lin-${MY_LANG}-${MY_PV}
S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${MY_P}.tgz
	use doc && cp "${DISTDIR}"/${MANFILE} "${S}"

}

src_install() {

	cd "${S}"
	dodir ${INSTALLDIR}
	# Copy all to INSTALLDIR
	cp -r . "${D}"/${INSTALLDIR}

	# Install the documentation
	dodoc README doc/*
	use doc && cp ${MANFILE} ${D}/usr/share/doc/${PF}
	doman man/eagle.1
	# Remove docs left in INSTALLDIR
	rm -rf "${D}"/${INSTALLDIR}/{README,install,${MANFILE}} "${D}"/${INSTALLDIR}/doc "${D}"/${INSTALLDIR}/man

	insinto /etc/env.d
	echo -e "PATH=${INSTALLDIR}/bin\nROOTPATH=${INSTALLDIR}/bin" > "${S}"/90eagle
	doins "${S}"/90eagle

	# Create desktop entry
	doicon bin/${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm "Graphics;Electronics"

}

pkg_postinst() {

	elog "Run \`env-update && source /etc/profile\` now to set up the correct paths."
	elog "You must first run eagle as root to invoke product registration."

}
