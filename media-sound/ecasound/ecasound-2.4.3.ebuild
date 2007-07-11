# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ecasound/ecasound-2.4.3.ebuild,v 1.8 2007/07/11 19:30:24 mr_bones_ Exp $

inherit multilib

IUSE="alsa arts audiofile debug jack libsamplerate mikmod ncurses vorbis oss python ruby sndfile"

DESCRIPTION="A package for multitrack audio processing"
SRC_URI="http://ecasound.seul.org/download/${P}.tar.gz"
HOMEPAGE="http://eca.cx/"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="amd64 ~ppc ~ppc-macos sparc x86"

DEPEND="jack? ( media-sound/jack-audio-connection-kit )
	media-libs/ladspa-sdk
	audiofile? ( media-libs/audiofile )
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )
	arts? ( kde-base/arts )
	libsamplerate? ( media-libs/libsamplerate )
	mikmod? ( media-libs/libmikmod )
	ruby? ( dev-lang/ruby )
	python? ( dev-lang/python )
	ncurses? ( sys-libs/ncurses )
	sndfile? ( media-libs/libsndfile )"

# We don't make RDEPEND for vorbis-tools, mpg123/mpg321, timidity++ or lame -- no
# use flags for them.

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i 's:map.h:map:g' configure
}

src_compile () {
	local myconf

	myconf="${myconf} --enable-shared --with-largefile"

	if use python; then
		#
		# ecasound is braindead about finding python includes/libdirs and
		# about where to install modules.  Luckily, it allows us to specify
		# all this.
		#
		local python_version python_prefix python_includes python_modules
		if use userland_Darwin ; then
			myconf="$myconf --enable-pyecasound=python"
		else
			myconf="$myconf --enable-pyecasound=c"
		fi
		python_version="`python -c 'import sys; print sys.version[:3]'`"
		python_prefix="`python -c 'import sys; print sys.prefix'`"

		python_includes="$python_prefix/include/python$python_version"
		python_modules="$python_prefix/$(get_libdir)/python$python_version"

		myconf="$myconf --with-python-includes=$python_includes"
		myconf="$myconf --with-python-modules=$python_modules"
	else
		myconf="$myconf --disable-pyecasound"
	fi

	econf \
	$(use_enable alsa) \
	$(use_enable arts) \
	$(use_enable audiofile) \
	$(use_enable debug) \
	$(use_enable jack) \
	$(use_enable libsamplerate) \
	$(use_enable ncurses) \
	$(use_enable oss) \
	$(use_enable ruby rubyecasound) \
	$(use_enable sndfile) \
	${myconf} \
	|| die "configure failed"
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

	dodoc BUGS NEWS README TODO
	dohtml `find Documentation -name "*.html"`
	dodoc Documentation/edi-list.txt
}

pkg_postinst() {
	if use arts; then
		ewarn "WARNING: You have requested ecasound ARTS support,"
		ewarn "this is no longer supported and will go away in"
		ewarn "future releases."
	fi
}
