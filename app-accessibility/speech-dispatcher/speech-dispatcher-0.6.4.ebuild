# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.6.4.ebuild,v 1.1 2007/08/30 06:09:31 williamh Exp $

inherit eutils

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa flite nas python"

DEPEND="dev-libs/dotconf
	>=dev-libs/glib-2
	dev-util/pkgconfig
	alsa? ( media-libs/alsa-lib )
	flite? ( app-accessibility/flite )
	nas? ( media-libs/nas )
	python? ( dev-lang/python )
	app-accessibility/espeak"

src_unpack() {
	unpack ${A}
	sed -i -e 's/\(DefaultModule.*\)flite/\1espeak/' ${S}/config/speechd.conf.in
	sed -i -e 's/\(SUBDIRS.*\)python/\1/' ${S}/src/Makefile.in
}

src_compile() {
	econf \
	$(use_with alsa) \
	$(use_with flite) \
	$(use_with nas) || die "configure failed"
	make all || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	if use python; then
		cd ${S}/src/python
		./setup.py install --root=${D} --no-compile
		cd ${S}
	fi

	insinto /usr/include
	doins ${S}/src/c/api/libspeechd.h

	dodoc AUTHORS ChangeLog NEWS TODO
	newinitd ${FILESDIR}/speech-dispatcher speech-dispatcher
}

pkg_postinst() {
	elog "The default synthesizer for speech-dispatcher in gentoo is espeak."
	elog "This has been set up in /etc/speech-dispatcher/speechd.conf."
	elog "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
}
