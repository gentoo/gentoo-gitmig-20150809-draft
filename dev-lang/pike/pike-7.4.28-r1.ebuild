# Copyright 1999-2003 Gentoo Technologies, Inc., Emil Skoldberg (see ChangeLog)
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pike/pike-7.4.28-r1.ebuild,v 1.4 2003/10/27 16:15:23 scandium Exp $

inherit flag-o-matic

# -fomit-frame-pointer breaks the compilation
filter-flags -fomit-frame-pointer

IUSE="debug doc gdbm gif gnome gtk java jpeg mysql oci8 odbc opengl pdflib postgres scanner tiff truetype zlib"

S="${WORKDIR}/Pike-v${PV}"
HOMEPAGE="http://pike.ida.liu.se/"
DESCRIPTION="Pike programming language and runtime"
SRC_URI="ftp://pike.ida.liu.se/pub/pike/all/${PV}/Pike-v${PV}.tar.gz"

LICENSE="GPL-2 | LGPL-2.1 | MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-libs/gmp
	zlib?	( sys-libs/zlib )
	pdflib? ( media-libs/pdflib )
	gdbm?	( sys-libs/gdbm )
	java?	( virtual/jdk )
	scanner? ( media-gfx/sane-backends )
	mysql?	( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	gif?	( media-libs/giflib )
	truetype? ( media-libs/freetype )
	jpeg?	( media-libs/jpeg )
	tiff?	( media-libs/tiff )
	opengl?	( virtual/opengl
		virtual/glut )
	gtk?	( =x11-libs/gtk+-1.2* )
	#gtk2?	( =x11-libs/gtk+-2* )
	sdl?	( media-libs/libsdl )
	sys-devel/gcc
	sys-devel/make
	sys-apps/sed"

src_compile() {

#       disable gtk+-2 for now, it does not work
#	if use gtk2; then
#		einfo 'If building pike with GTK+ 2.x support breaks try'
#		einfo 'USE="-gtk2" emerge pike'
#		sleep 3
#	fi

	local myconf
	use zlib  	|| myconf="${myconf} --without-zlib"
	use mysql 	|| myconf="${myconf} --without-mysql"
	use debug 	|| myconf="${myconf} --without-debug"
	use gdbm  	|| myconf="${myconf} --without-gdbm"
	use pdflib	|| myconf="${myconf} --without-libpdf"
	use java	|| myconf="${myconf} --without-java"
	use odbc	|| myconf="${myconf} --without-odbc"
	use scanner	|| myconf="${myconf} --without-sane"
	use postgres 	|| myconf="${myconf} --without-postgres"
	use oci8	|| myconf="${myconf} --without-oracle"
	use gif		|| myconf="${myconf} --without-gif"
	use truetype 	|| myconf="${myconf} --without-ttflib --without-freetype"
	use jpeg	|| myconf="${myconf} --without-jpeglib"
	use tiff	|| myconf="${myconf} --without-tifflib"
	use opengl	|| myconf="${myconf} --without-GL --without-GLUT"
	use gtk		&& myconf="${myconf} --with-GTK --without-GTK2" \
			|| myconf="${myconf} --without-GTK --without-GTK2"
#	disable gtk+-2 for now, it does not work
#	use gtk2	&& myconf="${myconf} --with-GTK2" \
#			|| myconf="${myconf} --without-GTK2"
	use gnome	|| myconf="${myconf} --without-gnome"

	# We have to use --disable-make_conf to override make.conf settings
	# Otherwise it may set -fomit-frame-pointer again
	# disable ffmpeg support because it does not compile
	# disable dvb support because it does not compile
	emake CONFIGUREARGS="${myconf} --prefix=/usr --disable-make_conf --without-ffmpeg --without-dvb" || die

	# only build documentation if 'doc' is in USE
	if use doc; then
		PATH="${S}/bin:${PATH}" make doc || die
	fi
}

src_install() {
	make INSTALLARGS="--traditional" buildroot="${D}" install || die

	if use doc; then
		einfo "Installing 60MB of docs, this could take some time ..."
		dohtml -r ${S}/refdoc/traditional_manual ${S}/refdoc/modref
	fi
}
