# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd/snd-7.10.ebuild,v 1.2 2005/04/08 17:34:00 hansmi Exp $

IUSE="esd motif guile X gtk ruby alsa"

S="${WORKDIR}/${P/\.*//}"
DESCRIPTION="Snd is a sound editor"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://snd.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 amd64 ppc sparc"

DEPEND="X? ( virtual/x11 )
	sci-libs/gsl
	media-libs/ladspa-sdk
	media-libs/audiofile
	esd? ( media-sound/esound )
	alsa? ( media-libs/alsa-lib )
	gtk? ( x11-libs/gtk+ )
	guile? ( dev-util/guile )
	motif? ( x11-libs/openmotif )
	ruby? ( virtual/ruby )"


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

# looks like gl is still broke
#	use gl \
#		&& myconf="${myconf} --with-just-gl" \
#		|| myconf="${myconf} --without-gl"

	econf --with-ladspa --with-float-samples \
		--with-float-sample-width ${myconf} || die

	emake || die
}

src_install () {
	dobin snd

	dodoc COPYING *.Snd *.scm *.rb *.png *.html

	cd tutorial
	dohtml *
	insinto /usr/share/doc/${PF}/html/images/jpg
	doins images/jpg/*
}
