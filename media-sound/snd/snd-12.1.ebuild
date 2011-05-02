# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd/snd-12.1.ebuild,v 1.2 2011/05/02 23:49:57 radhermit Exp $

EAPI=4

inherit multilib flag-o-matic

DESCRIPTION="Snd is a sound editor"
HOMEPAGE="http://ccrma.stanford.edu/software/snd/"
SRC_URI="ftp://ccrma-ftp.stanford.edu/pub/Lisp/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="alsa esd fam fftw gmp gsl gtk jack ladspa motif opengl oss portaudio pulseaudio ruby"

RDEPEND="media-libs/audiofile
	sys-libs/readline
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	fam? ( virtual/fam )
	fftw? ( sci-libs/fftw )
	gmp? ( dev-libs/gmp
		dev-libs/mpc
		dev-libs/mpfr )
	gsl? ( >=sci-libs/gsl-0.8 )
	gtk? ( || ( x11-libs/gtk+:3 x11-libs/gtk+:2 )
		x11-libs/pango
		x11-libs/cairo
		opengl? ( x11-libs/gtkglext ) )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/ladspa-sdk )
	motif? ( >=x11-libs/openmotif-2.3:0 )
	opengl? ( virtual/opengl )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	ruby? ( dev-lang/ruby )"

pkg_setup() {
	if ! use gtk && ! use motif; then
		ewarn "Warning: no graphic toolkit selected (gtk or motif)."
		ewarn "Upstream suggests to enable one of the toolkits (or both)"
		ewarn "or only the command line utilities will be helpful."
	fi
}

src_configure() {
	# Workaround executable sections QA warning (bug #348754)
	append-ldflags -Wl,-z,noexecstack

	local myconf
	if use opengl; then
		myconf="${myconf} --with-just-gl"
	else
		myconf="${myconf} --without-gl"
	fi

	econf \
		$(use_with alsa) \
		$(use_with esd) \
		$(use_with fam) \
		$(use_with fftw) \
		$(use_with gmp) \
		$(use_with gsl) \
		$(use_with gtk) \
		$(use_with jack) \
		$(use_with ladspa) \
		$(use_with motif) \
		$(use_with oss) \
		$(use_with portaudio) \
		$(use_with pulseaudio) \
		$(use_with ruby) \
		--with-float-samples \
		${myconf}

}

src_compile() {
	emake snd

	# Do not compile ruby extensions for command line programs since they fail
	sed -i -e "s:HAVE_RUBY 1:HAVE_RUBY 0:" mus-config.h

	for i in sndinfo audinfo sndplay; do
	   emake ${i}
	done
}

src_install () {
	dobin snd
	dobin sndplay
	dobin sndinfo
	dobin audinfo

	insinto /usr/$(get_libdir)/snd/scheme
	doins *.scm

	dodoc README.Snd HISTORY.Snd NEWS
	dohtml -r *.html pix/*.png tutorial
}
