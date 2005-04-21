# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-0.20050420.ebuild,v 1.1 2005/04/21 10:25:52 tove Exp $

#inherit toolchain-funcs distutils
inherit toolchain-funcs

MY_P="${P/./-}"

DESCRIPTION="window manager improved 2 -- is the next generation of the WMI project."
HOMEPAGE="http://wmi.modprobe.de/index.php?n=WMII.Overview"
SRC_URI="http://wmi.modprobe.de/snaps/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="python cairo"

DEPEND=">=sys-apps/sed-4
	${RDEPEND}"
RDEPEND="virtual/x11
	virtual/libc
	cairo? ( >=x11-libs/cairo-0.3
		>=media-libs/freetype-2 )
	python? ( virtual/python
		dev-python/pyrex )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i \
		-e "/^CFLAGS/s/-O0 -g/${CFLAGS}/" \
		-e "/^LDFLAGS/s/-g -Wl/${LDFLAGS}/" \
		"${S}"/config.mk

	if useq cairo; then
		sed -i \
			-e "/^#DRAW/,/^#CAIROINC/ s/^#//g" \
			"${S}"/config.mk
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" CONFPREFIX=/etc || die "emake failed"

#	useq python && cd "${S}"/libixp/python && distutils_src_compile
	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py build || die "python build failed."
	fi
}

src_install() {
	make DESTDIR="${D}" PREFIX=/usr CONFPREFIX=/etc install || die
	dodoc CHANGES README LICENSE || die "dodoc failed."

#	useq python && cd "${S}"/libixp/python && distutils_src_instal
	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py install --root="${D}" || die "python install failed."
	fi

	exeinto /usr/share/"${PN}"/contrib
	doexe "${S}"/contrib/*.py || die "contrib failed."

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}"/"${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}"/"${PN}" || die "/etc/X11/Sessions failed."

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/"${PN}".desktop || die "${PN}.desktop failed."
}
