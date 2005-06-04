# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-1.ebuild,v 1.2 2005/06/04 20:17:27 tester Exp $

inherit toolchain-funcs

DESCRIPTION="window manager improved 2 -- the next generation of the WMI project."
HOMEPAGE="http://wmi.modprobe.de/index.php/WMII/Overview"
SRC_URI="http://wmi.modprobe.de/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
#IUSE="python cairo"
IUSE="python"

DEPEND=">=sys-apps/sed-4
	${RDEPEND}"
RDEPEND="virtual/x11
	python? ( dev-python/pyrex )"
#	cairo? ( >=x11-libs/cairo-0.3
#		>=media-libs/freetype-2 )"

src_unpack() {
	unpack "${A}"

	sed -i \
		-e "/^CFLAGS/ s/-O0 -g/${CFLAGS}/" \
		-e "/^LDFLAGS/ s/-g/${LDFLAGS}/" \
		"${S}"/config.mk

# removed because cairo backend crashes much too often
#	if useq cairo; then
#		sed -i \
#			-e "/^#DRAW/,/^#CAIROINC/ s/^#//" \
#			"${S}"/config.mk
#	fi
}

src_compile() {
	emake CC="$(tc-getCC)" \
		AR="$(tc-getAR) cr" \
		RANLIB="$(tc-getRANLIB)" \
		CONFPREFIX=/etc || die "emake failed"

	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py build || die "python build failed."
	fi
}

src_install() {
	make DESTDIR="${D}" \
		AR="$(tc-getAR) cr" \
		RANLIB="$(tc-getRANLIB)" \
		PREFIX=/usr \
		CONFPREFIX=/etc install || die "make install failed."
	dodoc ANNOUNCE CHANGES README LICENSE docs/welcome.txt || die "dodoc failed."

	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py install --root="${D}" || die "python install failed."
	fi

	exeinto /usr/share/"${PN}"/contrib
	doexe "${S}"/contrib/* || die "contrib failed."

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}"/"${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}"/"${PN}" || die "/etc/X11/Sessions failed."

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/"${PN}".desktop || die "${PN}.desktop failed."
}
