# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd/snd-6.ebuild,v 1.1 2002/08/06 07:42:05 naz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Snd is a sound editor"
SRC_URI="ftp://ccrma-ftp.stanford.edu/pub/Lisp/${P}.tar.gz"
HOMEPAGE="http://www-ccrma.stanford.edu/software/snd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="X? ( virtual/x11 )
	dev-libs/gsl
	media-libs/ladspa-sdk
	media-libs/audiofile
	esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )
	gtk? ( x11-libs/gtk+ )
	guile? ( dev-util/guile )
	motif? ( x11-libs/openmotif )
	ruby? ( dev-lang/ruby )"


src_compile() {
	local myconf

	use alsa \
		&& myconf="${myconf} --with-alsa" \
		|| myconf="${myconf} --without-alsa"

	use esd \
		&& myconf="${myconf} --with-esd" \
		|| myconf="${myconf} --without-esd"

	use gtk \
		&& myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"

	use guile \
		&& myconf="${myconf} --with-guile --with-run" \
		|| myconf="${myconf} --without-guile"

	use ruby \
		&& myconf="${myconf} --with-ruby" \
		|| myconf="${myconf} --without-ruby"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

# Seems to cause problem I will look into it but for now we will just disable
#	use gl \
#		&& myconf="${myconf} --with-just-gl" \
#		|| myconf="${myconf} --without-gl"

	econf --with-ladspa --with-float-samples \
		--with-float-sample-width ${myconf} || die
	
	emake || die 
}

src_install () {

	dobin snd
	
	dodoc COPYING HISTORY.Snd README.Snd TODO.Snd
	
	cd contrib/tutorial
	dohtml *
}
