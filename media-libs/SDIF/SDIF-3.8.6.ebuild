# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SDIF/SDIF-3.8.6.ebuild,v 1.1 2004/09/03 03:56:07 chriswhite Exp $

inherit eutils

MY_P=${P}-src
DESCRIPTION="The Sound Description Interchange Format Library is a library that deals with audio and wave processing."
HOMEPAGE="http://www.ircam.fr/anasyn/sdif"
SRC_URI="http://www.ircam.fr/anasyn/sdif/download/${MY_P}.tar.gz
		doc? ( http://www.ircam.fr/anasyn/sdif/download/${PN}-doc.tar.gz  )"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc threads ftruncate debug"
DEPEND=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	# a hack that I need to bother upstream about
	# they don't want to use the "Package-Name-Docs/file1.html" format
	# instead it's just file1.html :|
	unpack ${MY_P}.tar.gz
	mkdir ${WORKDIR}/SDIF-doc
	use doc && tar xfz ${DISTDIR}/${PN}-doc.tar.gz -C ${WORKDIR}/SDIF-doc
}

src_compile() {
	cd ${S}

	#custom cflags...
	epatch ${FILESDIR}/${P}-cflags.patch

	local myconf=""
	myconf="${myconf} $(use_enable debug)"
	myconf="${myconf} $(use_enable ftruncate)"
	myconf="${myconf} $(use_enable threads pthreads)"

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	use doc && dohtml -r ${WORKDIR}/SDIF-doc
}
