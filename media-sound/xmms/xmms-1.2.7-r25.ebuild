# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.7-r25.ebuild,v 1.11 2004/02/03 09:48:55 eradicator Exp $

IUSE="xml nls esd gnome opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk"

inherit libtool flag-o-matic eutils
filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

PATCHVER=0.1

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-patches-${PATCHVER}.tar.bz2
	( mmx?||3dnow? ) ( http://members.jcom.home.ne.jp/jacobi/linux/etc/${P}-mmx.patch.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~ia64"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.6 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	!gtk2? ( gnome? ( <gnome-base/gnome-panel-1.5.0 ) )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	nls? ( dev-util/intltool )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="$DEPEND
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${PATCHDIR}/xmms-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${PATCHDIR}/xmms-sigterm.patch

	# Patch to stop crashing with nptl bug #26172
	epatch ${PATCHDIR}/xmms-nptl.patch

	# The following optimisations are ONLY for x86 platform
	if [ `use x86` ] ; then
		# For mmx/3dnow enabled CPUs, this patch adds mmx/3dnow optimisations
		#
		# ( use mmx || use 3dnow ) && \
		# 	cat ${DISTDIR}/${P}-mmx.patch.gz | gunzip -c | patch -p1 || die
		#
		# For you guys who favour this kind of USE flag checking ... this
		# is exactly why I do NOT like it, because the actual
		# "cat ${DISTDIR}/${P}-mmx.patch.gz | gunzip -c | patch -p1 || die"
		# was not in a subshell, it would ALWAYS fail to build if "mmx" or
		# "3dnow" was not in USE, because of the || die at the end.  So
		# PLEASE, PLEASE test things with all possible USE flags if you use
		# this style!!!!  Then, if in a subshell, it do not detect if the
		# command fails :/
		#
		# Azarah - 30 Jun 2002
		#
		if use mmx || use 3dnow
		then
			epatch ${DISTDIR}/${P}-mmx.patch.gz
			use ipv6 && epatch ${PATCHDIR}/xmms-ipv6-20020408-mmx.patch
		else
			use ipv6 && epatch ${PATCHDIR}/xmms-ipv6-20020408-nommx.patch
		fi
	else
		use ipv6 && epatch ${PATCHDIR}/xmms-ipv6-20020408-nommx.patch
	fi

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	# the Japanese patch and the Russian one overlap, so its one or the other
	if use cjk; then
		epatch ${PATCHDIR}/${P}-mpg123j.patch
	else
		# add russian charset support
		epatch ${PATCHDIR}/xmms-russian-charset.patch
	fi

	if [ ! -f ${S}/config.rpath ] ; then
		touch ${S}/config.rpath
		chmod +x ${S}/config.rpath
	fi

	# Add /usr/local/share/xmms/Skins to the search path for skins
	epatch ${PATCHDIR}/${PN}-fhs-skinsdir.patch

	# We run automake and autoconf here else we get a lot of warning/errors.
	# I have tested this with gcc-2.95.3 and gcc-3.1.
	elibtoolize

	if use nls; then
		if has_version '>=sys-devel/gettext-0.12'; then
			epatch ${PATCHDIR}/${PN}-gettext-fix.patch
		fi
	fi

	# This patch passes audio output through the output plugin
	# before recording via the diskwriter plugin
	# http://forum.xmms.org/viewtopic.php?t=500&sid=c286e1c01fb924a2f81f519969f33764
	epatch ${PATCHDIR}/xmms-diskwriter-audio.patch

	echo ">>> Reconfiguring..."
	for x in ${S} ${S}/libxmms
	do
		cd ${x}
		aclocal
		export WANT_AUTOCONF=2.5
		automake --gnu --add-missing --include-deps Makefile || die
		autoconf || die
	done
}

src_compile() {
	local myconf=""

	# Allow configure to detect mipslinux systems
	use mips && gnuconfig_update

	use 3dnow || use mmx \
		&& myconf="${myconf} --enable-simd" \
		|| myconf="${myconf} --disable-simd"

	use xml \
		|| myconf="${myconf} --disable-cdindex"

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_with gnome` \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_with oggvorbis ogg` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		${myconf} || die

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
