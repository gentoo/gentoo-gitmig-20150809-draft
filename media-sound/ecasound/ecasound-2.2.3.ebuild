# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ecasound/ecasound-2.2.3.ebuild,v 1.6 2004/01/22 11:50:22 torbenh Exp $

IUSE="ncurses arts alsa python oss mikmod oggvorbis jack"

S=${WORKDIR}/${P}
DESCRIPTION="A package for multitrack audio processing"
SRC_URI="http://ecasound.seul.org/download/${P}.tar.gz"
HOMEPAGE="http://eca.cx/"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="x86"

DEPEND="virtual/glibc
	jack?	( virtual/jack )
	media-libs/ladspa-sdk
	media-libs/audiofile
	alsa?	( media-libs/alsa-lib )
	oggvorbis?	( media-libs/libvorbis )
	arts?	( kde-base/arts )
	mikmod?	( media-libs/libmikmod )
	python?		( dev-lang/python )
	ncurses?	( sys-libs/ncurses )"

# We don't make RDEPEND for vorbis-tools, mpg123/mpg321, timidity++ or lame -- no
# use flags for them.

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i 's:map.h:map:g' configure
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" libecasound/plugins/audioio_alsa.cpp
	sed -i "/#include <alsa\\/asoundlib.h>/i\\#define ALSA_PCM_OLD_HW_PARAMS_API 1\\" libecasound/plugins/audioio_alsa_named.cpp
}

src_compile () {
	local myconf

	use jack || myconf="$myconf --disable-jack"
	use alsa || myconf="$myconf --disable-alsa"
	use arts || myconf="$myconf --disable-arts"
	use ncurses || myconf="$myconf --disable-ncurses"
	use audiofile || myconf="$myconf --disable-audiofile"
	use oss || myconf="$myconf --disable-oss"

	if use python; then
		#
		# ecasound is braindead about finding python includes/libdirs and
		# about where to install modules.  Luckily, it allows us to specify
		# all this.
		#
		local python_version python_prefix python_includes python_modules
		python_version="`python -c 'import sys; print sys.version[:3]'`"
		python_prefix="`python -c 'import sys; print sys.prefix'`"

		python_includes="$python_prefix/include/python$python_version"
		python_modules="$python_prefix/lib/python$python_version"

		# ecasound configure assumes `disable' if you pass
		# --(enable|disable)-pyecasound.  *sigh*
		#myconf="$myconf --enable-pyecasound"

		myconf="$myconf --with-python-includes=$python_includes"
		myconf="$myconf --with-python-modules=$python_modules"
	else
		myconf="$myconf --disable-pyecasound"
	fi

	einfo "configuring with ${myconf}"
	econf ${myconf} || die "configure failed"
	make || die "build failed"
}

src_install () {
	make DESTDIR=${D} install || die

	if use python; then
		cd pyecasound || die
		python -c "import compileall; compileall.compile_dir('.')" || die
		python -O -c "import compileall; compileall.compile_dir('.')" || die
		python_sitepkgsdir="`python -c "import sys; print (sys.prefix + '/lib/python' + sys.version[:3] + '/site-packages/')"`"
		install *.pyc *.pyo "${D}/${python_sitepkgsdir}"
		cd ..
	fi

	dodoc INSTALL FAQ BUGS COPYING NEWS README TODO
	dohtml `find Documentation -name "*.html"`
	dodoc Documentation/edi-list.txt
}
