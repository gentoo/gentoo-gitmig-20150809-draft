# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.7-r21.ebuild,v 1.2 2003/05/17 08:23:59 jje Exp $

IUSE="xml nls esd gnome opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk"

inherit libtool flag-o-matic eutils

filter-flags "-fforce-addr"

S="${WORKDIR}/${P}"
DESCRIPTION="X MultiMedia System"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.gz
	 mmx? ( http://members.jcom.home.ne.jp/jacobi/linux/etc/${P}-mmx.patch.gz )"
HOMEPAGE="http://www.xmms.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

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
	unpack ${P}.tar.gz

	cd ${S}

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${FILESDIR}/xmms-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${FILESDIR}/xmms-sigterm.patch

	# The following optimisations are ONLY for x86 platform
	use x86 && ( \
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
			use ipv6 && epatch ${FILESDIR}/xmms-ipv6-20020408-mmx.patch
		else
			use ipv6 && epatch ${FILESDIR}/xmms-ipv6-20020408-nommx.patch
		fi
	)

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	if use cjk; then
		epatch ${FILESDIR}/${P}-mpg123j.patch
	fi

	# Patch for improved xmms-sid - xmms-sid plugin must be rebuilt
	# after this is applied
	epatch ${FILESDIR}/${P}-songpos.patch
	
	[ ! -f ${S}/config.rpath ] && ( \
		touch ${S}/config.rpath
		chmod +x ${S}/config.rpath
	)

	# We run automake and autoconf here else we get a lot of warning/errors.
	# I have tested this with gcc-2.95.3 and gcc-3.1.
	elibtoolize
	echo ">>> Reconfiguring..."
	for x in ${S} ${S}/libxmms
	do
		cd ${x}
		aclocal
		export WANT_AUTOCONF_2_5=1
		automake --gnu --add-missing --include-deps Makefile || die
		autoconf || die
	done
}

src_compile() {
	local myconf=""

	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome"

	use 3dnow || use mmx \
		&& myconf="${myconf} --enable-simd" \
		|| myconf="${myconf} --disable-simd"

	use esd \
		&& myconf="${myconf} --enable-esd --enable-esdtest" \
		|| myconf="${myconf} --disable-esd --disable-esdtest"

	use mikmod \
		&& myconf="${myconf} --enable-mikmod --enable-mikmodtest \
			--with-libmikmod" \
		|| myconf="${myconf} --disable-mikmod --disable-mikmodtest \
			--without-libmikmod"

	use opengl \
		&& myconf="${myconf} --enable-opengl" \
		|| myconf="${myconf} --disable-opengl"
	
	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis --enable-oggtest \
			--enable-vorbistest --with-ogg" \
		|| myconf="${myconf} --disable-vorbis --disable-oggtest \
			--disable-vorbistest --without-ogg"

	use xml \
		|| myconf="${myconf} --disable-cdindex"

	use nls \
		|| myconf="${myconf} --disable-nls"

	use ipv6 && myconf="${myconf} --enable-ipv6"

	# this is here for people who boot with gentoo=nodevfs
	# see #20647 for details.
	if [ -e /dev/sound ]
	then
		myconf="${myconf} \
			--with-dev-dsp=/dev/sound/dsp \
			--with-dev-mixer=/dev/sound/mixer"
	fi

	econf ${myconf} || die

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
	
	dodir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	donewins gnomexmms/gnomexmms.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	use gnome && ( \
		insinto /usr/share/gnome/apps/Multimedia
		doins xmms/xmms.desktop
		dosed "s:xmms_mini.xpm:mini/xmms_mini.xpm:" \
			/usr/share/gnome/apps/Multimedia/xmms.desktop
	) || ( \
		rm ${D}/usr/share/man/man1/gnomexmms*
	)

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

