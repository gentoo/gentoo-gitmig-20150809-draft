# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.8.ebuild,v 1.1 2003/09/12 17:36:54 seemant Exp $

IUSE="xml nls esd gnome opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk"

inherit libtool flag-o-matic eutils
filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="X MultiMedia System"
SRC_URI="http://www.xmms.org/files/1.2.x/${MY_P}.tar.bz2"
HOMEPAGE="http://www.xmms.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="app-arch/unzip
	=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.6 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	gnome? ( <gnome-base/gnome-panel-1.5.0 )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"
RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	nls? ( dev-util/intltool )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${FILESDIR}/xmms-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${FILESDIR}/xmms-sigterm.patch

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	# the Japanese patch and the Russian one overlap, so its one or the other
	if use nls
	then
		if use cjk; then
			epatch ${FILESDIR}/${P}-mpg123j.patch
#		else
#			# add russian charset support
#			epatch ${FILESDIR}/${P}-russian-charset.patch
		fi
	fi

	if [ ! -f ${S}/config.rpath ] ; then
		touch ${S}/config.rpath
		chmod +x ${S}/config.rpath
	fi

	# Add /usr/local/share/xmms/Skins to the search path for skins
	epatch ${FILESDIR}/${PN}-fhs-skinsdir.patch

	# We run automake and autoconf here else we get a lot of warning/errors.
	# I have tested this with gcc-2.95.3 and gcc-3.1.
	elibtoolize

	# This patch passes audio output through the output plugin 
	# before recording via the diskwriter plugin
	# http://forum.xmms.org/viewtopic.php?t=500&sid=c286e1c01fb924a2f81f519969f33764
	epatch ${FILESDIR}/xmms-diskwriter-audio.patch

	echo ">>> Reconfiguring..."
	for x in ${S} ${S}/libxmms
	do
		cd ${x}
		aclocal
		automake --gnu --add-missing --include-deps Makefile || die
		autoconf || die
	done

	# fix broken makefile in gnomexmms
#	sed -i "s:\@LTLIBSINTL\@$::" ${S}/gnomexmms/Makefile.in
}

src_compile() {
	local myconf=""

	if use 3dnow || use mmx
	then
		myconf="${myconf} --enable-simd"
	else
		myconf="${myconf} --disable-simd"
	fi

	use xml \
		|| myconf="${myconf} --disable-cdindex"

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		${myconf} || die
	#	`use_with gnome` \
	#	`use_with mikmod libmikmod` \
	#	`use_with oggvorbis ogg` \

	### emake seems to break some compiles, please keep @ make
	make || die
}

src_install() {
	make prefix=${D}/usr \
		datadir=${D}/usr/share \
		incdir=${D}/usr/include \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc install || die "FOO"

	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
	
	keepdir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	donewins gnomexmms/gnomexmms.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	if [ `use gnome` ] ; then
		insinto /usr/share/gnome/apps/Multimedia
		doins xmms/xmms.desktop
		dosed "s:xmms_mini.xpm:mini/xmms_mini.xpm:" \
			/usr/share/gnome/apps/Multimedia/xmms.desktop
	else
		rm ${D}/usr/share/man/man1/gnomexmms*
	fi

	# causes segfaults for ppc users #10309 and after talking
	# to xmms dev's, they've punted this from the src tree anyways ...
	rm -rf ${D}/usr/lib/xmms/Input/libidcin.so
}

pkg_postrm() {
	if [ -x ${ROOT}/usr/bin/xmms ] && [ ! -d ${ROOT}/usr/share/xmms/Skins ]
	then
		mkdir -p ${ROOT}/usr/share/xmms/Skins
	fi
}
