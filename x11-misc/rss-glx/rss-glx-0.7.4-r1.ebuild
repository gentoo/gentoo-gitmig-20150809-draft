# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss-glx/rss-glx-0.7.4-r1.ebuild,v 1.8 2004/02/01 23:40:20 vapier Exp $

inherit flag-o-matic
use kde && inherit kde

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Really Slick Screensavers using OpenGL for XScreenSaver"
HOMEPAGE="http://rss-glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/rss-glx/${MY_P}.tar.bz2"

IUSE="kde sse 3dnow"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	virtual/opengl
	>=sys-apps/sed-4
	kde? ( kde-base/kdeartwork ) : ( x11-misc/xscreensaver )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-kdedesktop.patch
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	filter-flags -fPIC

	local myconf

	myconf="${myconf} --bindir=/usr/lib/xscreensaver" \
	myconf="${myconf} --with-configdir=/usr/share/control-center/screensavers/" \

	if [ -n "`use kde`" ]; then
		local desktopfile=`find . -name \*.desktop`
		for x in $desktopfile; do
			sed -i -e 's:Exec=kxsrun \(.*\):Exec=kxsrun /usr/lib/xscreensaver/\1:g' \
				   -e 's:Exec=kxsconfig \(.*\):Exec=kxsconfig /usr/lib/xscreensaver/\1:g' \
				   $x
		done

		[ -n "${KDEDIR}" ] \
			&& myconf="${myconf} --with-kdessconfigdir=${KDEDIR}/share/applnk/System/ScreenSavers"
	fi

	econf \
		`use_enable sse` \
		`use_enable 3dnow` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc COPYING INSTALL README README.xscreensaver

	# symlink to satisfy kde's kxs*
	use kde && dosym /usr/share/control-center/screensavers /usr/lib/xscreensaver/config
}

pkg_postinst() {
	if [ -f ${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver ]; then
		einfo "Adding Really Slick Screensavers to XScreenSaver"

		sed -i '/*programs:/a\
	GL:       \"Cyclone\"  cyclone --root     \\n\\\
	GL:      \"Euphoria\"  euphoria --root    \\n\\\
	GL:    \"Fieldlines\"  fieldlines --root  \\n\\\
	GL:        \"Flocks\"  flocks --root      \\n\\\
	GL:          \"Flux\"  flux --root        \\n\\\
	GL:        \"Helios\"  helios --root      \\n\\\
	GL:       \"Lattice\"  lattice --root     \\n\\\
	GL:        \"Plasma\"  plasma --root      \\n\\\
	GL:     \"Skyrocket\"  skyrocket --root   \\n\\\
	GL:    \"Solarwinds\"  solarwinds --root  \\n\\\
	GL:     \"Colorfire\"  colorfire --root   \\n\\\
	GL:  \"Hufos Smoke\"  hufo_smoke --root  \\n\\\
	GL: \"Hufos Tunnel\"  hufo_tunnel --root \\n\\\
	GL:    \"Sundancer2\"  sundancer2 --root  \\n\\\
	GL:          \"BioF\"  biof --root        \\n\\\
	GL:   \"BusySpheres\"  busyspheres --root \\n\\' \
	${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver

	else
		einfo "Unable to add these to XScreenSaver configuration"
		einfo "Read /usr/share/doc/${PF}/README.xscreensaver.gz for"
		einfo "entries to add to your ~/.xscreensaver file to enable these hacks"
	fi
}

pkg_postrm() {
	if [ -f ${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver ]; then
		einfo "Removing Really Slick Screensavers from XScreenSaver configuration."
		sed -e '/\"Cyclone\"  cyclone/d' \
			-e '/\"Euphoria\"  euphoria/d' \
			-e '/\"Fieldlines\"  fieldlines/d' \
			-e '/\"Flocks\"  flocks/d' \
			-e '/\"Flux\"  flux/d' \
			-e '/\"Helios\"  helios/d' \
			-e '/\"Lattice\"  lattice/d' \
			-e '/\"Plasma\"  plasma/d' \
			-e '/\"Skyrocket\"  skyrocket/d' \
			-e '/\"Solarwinds\"  solarwinds/d' \
			-e '/\"Colorfire\"  colorfire/d' \
			-e '/\"Hufos Smoke\"  hufo_smoke/d' \
			-e '/\"Hufos Tunnel\"  hufo_tunnel/d' \
			-e '/\"Sundancer2\"  sundancer2/d' \
			-e '/\"BioF\"  biof/d' \
			-e '/\"BusySpheres\"  busyspheres/d' -i \
		${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver
	fi
}

