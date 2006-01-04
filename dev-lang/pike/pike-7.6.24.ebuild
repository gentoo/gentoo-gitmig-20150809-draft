# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pike/pike-7.6.24.ebuild,v 1.8 2006/01/04 00:23:52 vapier Exp $

IUSE="crypt debug doc fftw gdbm gif gtk hardened jpeg kerberos opengl pdflib scanner svg tiff truetype zlib"

S="${WORKDIR}/Pike-v${PV}"
HOMEPAGE="http://pike.ida.liu.se/"
DESCRIPTION="Pike programming language and runtime"
SRC_URI="http://pike.ida.liu.se/pub/pike/all/${PV}/Pike-v${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="x86 ppc amd64"

DEPEND="crypt?	( dev-libs/nettle )
	fftw?	( sci-libs/fftw )
	gdbm?	( sys-libs/gdbm )
	gif?	( media-libs/giflib )
	gtk?	( =x11-libs/gtk+-1.2* )
	jpeg?	( media-libs/jpeg )
	kerberos? ( virtual/krb5 )
	opengl? ( virtual/opengl
		virtual/glut )
	pdflib?	( media-libs/pdflib )
	scanner? ( media-gfx/sane-backends )
	svg?	( gnome-base/librsvg )
	tiff?	( media-libs/tiff )
	truetype? ( media-libs/freetype )
	zlib?	( sys-libs/zlib )
	dev-libs/gmp"

src_compile() {
	local myconf=""
	# ffmpeg is broken atm #110136
	myconf="${myconf} --without-_Ffmpeg"
	# on hardened, disable runtime-generated code
	# otherwise let configure work it out for itself
	use hardened && myconf="${myconf} --without-machine-code"
	emake CONFIGUREARGS="--prefix=/usr --disable-make_conf \
			`use_with debug` \
			`use_with crypt nettle` \
			`use_with fftw` \
			`use_with gdbm` \
			`use_with gif` \
			`use_with gtk GTK` \
			`use_with jpeg jpeglib` \
			`use_with kerberos krb5` \
			`use_with opengl GL` \
			`use_with opengl GLUT` \
			`use_with pdflib libpdf` \
			`use_with scanner sane` \
			`use_with svg` \
			`use_with tiff tifflib` \
			`use_with truetype ttflib` \
			`use_with truetype freetype` \
			`use_with zlib` \
			${myconf} \
			${EXTRA_ECONF} \
			" || die

	if use doc; then
		PATH="${S}/bin:${PATH}" make doc || die
	fi
}

src_install() {
	# the installer should be stopped from removing files, to prevent sandbox issues
	sed -i s/rm\(mod\+\"\.o\"\)\;/\{\}/ ${S}/bin/install.pike || die "Failed to modify install.pike"

	if use doc; then
		make INSTALLARGS="--traditional" buildroot="${D}" install || die
		einfo "Installing 60MB of docs, this could take some time ..."
		dohtml -r ${S}/refdoc/traditional_manual ${S}/refdoc/modref
	else
		make INSTALLARGS="--traditional" buildroot="${D}" install_nodoc || die
	fi
}
