# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss-glx/rss-glx-0.7.6.ebuild,v 1.12 2004/07/24 06:05:18 liquidx Exp $

inherit flag-o-matic eutils kde

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Really Slick Screensavers using OpenGL for XScreenSaver"
HOMEPAGE="http://rss-glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc amd64 ~sparc"
IUSE="kde sse 3dnow openal"

DEPEND="virtual/x11
	virtual/opengl
	>=sys-apps/sed-4
	>=media-gfx/imagemagick-5.5.7
	kde? ( kde-base/kdeartwork )
	!kde? ( x11-misc/xscreensaver kde-base/kde-env )
	openal? ( media-libs/openal )"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-0.7.4-kdedesktop.patch
}

src_compile() {
	filter-flags -fPIC

	local myconf

	myconf="${myconf} --bindir=/usr/lib/xscreensaver" \
	myconf="${myconf} --with-configdir=/usr/share/control-center/screensavers/" \

	if use kde; then
		find . -name '*.desktop' -exec \
			sed -i \
				-e 's:Exec=kxsrun \(.*\):Exec=kxsrun \1:g' \
				-e 's:Exec=kxsconfig \(.*\):Exec=kxsconfig \1:g' \
				'{}' \
			\; \
			|| die "couldnt sed desktop files"
		[ -n "${KDEDIR}" ] \
			&& myconf="${myconf} --with-kdessconfigdir=${KDEDIR}/share/applnk/System/ScreenSavers"
	fi

	econf \
		`use_enable sse` \
		`use_enable 3dnow` \
		`use_enable openal sound` \
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
	local XSCREENSAVER_CONF="${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver"

	if [ -f ${XSCREENSAVER_CONF} -a -z "`grep 'Euphoria' ${XSCREENSAVER_CONF}`" ]; then
		einfo "Adding Really Slick Screensavers to XScreenSaver"
		sed -e '/*programs:/a\
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
	GL:   \"Hufos Smoke\"  hufo_smoke --root  \\n\\\
	GL:  \"Hufos Tunnel\"  hufo_tunnel --root \\n\\\
	GL:    \"Sundancer2\"  sundancer2 --root  \\n\\\
	GL:          \"BioF\"  biof --root        \\n\\\
	GL:    \"MatrixView\"  matrixview --root  \\n\\\
	GL:   \"Spirographx\"  spirographx --root \\n\\\
	GL:   \"BusySpheres\"  busyspheres --root \\n\\' \
		-i ${XSCREENSAVER_CONF}

	else
		einfo "Unable to add these to XScreenSaver configuration"
		einfo "Read /usr/share/doc/${PF}/README.xscreensaver.gz for"
		einfo "entries to add to your ~/.xscreensaver file to enable these hacks"
	fi
}

pkg_postrm() {
	local XSCREENSAVER_CONF="${ROOT}/usr/X11R6/lib/X11/app-defaults/XScreenSaver"

	has_version rss-glx && return 0
	if [ -f ${XSCREENSAVER_CONF} ]; then
		einfo "Removing Really Slick Screensavers from XScreenSaver configuration."
		sed \
			-e '/\"Cyclone\"  cyclone/d' \
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
			-e '/\"MatrixView\"  matrixview/d' \
			-e '/\"Spirographx\"  spirographx/d' \
			-e '/\"BusySpheres\"  busyspheres/d' \
			-i ${XSCREENSAVER_CONF}
	fi
}
