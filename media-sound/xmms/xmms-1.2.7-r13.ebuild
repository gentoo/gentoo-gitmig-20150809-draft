# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.7-r13.ebuild,v 1.3 2002/09/16 01:10:17 murphy Exp $

inherit libtool flag-o-matic

filter-flags "-fforce-addr"

S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.gz
	 mmx? ( http://members.jcom.home.ne.jp/jacobi/linux/etc/${P}-mmx.patch.gz )"
HOMEPAGE="http://www.xmms.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="app-arch/unzip
	=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.6 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	gnome? ( <gnome-base/gnome-panel-1.5.0 )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"
	

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}

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
			cat ${DISTDIR}/${P}-mmx.patch.gz | gunzip -c | patch -p1 || die
		fi
	)

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
		automake --gnu --include-deps Makefile || die
		autoconf || die
	done
}

src_compile() {
	local myconf=""

	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome"

	use 3dnow || use mmx  \
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

	econf ${myconf} || die

	emake || die
}

src_install() {

	einstall \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc || die

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
}

pkg_postrm() {

	if [ -x ${ROOT}/usr/bin/xmms ] && [ ! -d ${ROOT}/usr/share/xmms/Skins ]
	then
		mkdir -p ${ROOT}/usr/share/xmms/Skins
	fi
}
