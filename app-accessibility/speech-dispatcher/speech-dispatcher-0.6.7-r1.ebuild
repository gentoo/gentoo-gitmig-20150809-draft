# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.6.7-r1.ebuild,v 1.4 2010/03/01 21:05:51 patrick Exp $

EAPI="3"
PATCHVER=1

inherit autotools eutils

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCHVER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa +espeak flite nas pulseaudio python"

RDEPEND="dev-libs/dotconf
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	espeak? ( app-accessibility/espeak )
	flite? ( >=app-accessibility/flite-1.3 )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio
		dev-libs/libatomic_ops )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch ${FILESDIR}/speech-dispatcher-mutils.patch \
		${FILESDIR}/speech-dispatcher-0.6.6-festival-fix-formats.patch
	eautoreconf
	sed -i -e 's/\(SUBDIRS.*\)python/\1/' src/Makefile.in
}

src_configure() {
	econf \
		$(use_with alsa) \
		$(use_with espeak) \
		$(use_with flite) \
		$(use_with pulseaudio pulse) \
		$(use_with nas)
}

src_compile() {
	emake all || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		cd "${S}"/src/python
		./setup.py install --root="${D}" --no-compile
		cd "${S}"
	fi

	insinto /usr/include
	doins "${S}"/src/c/api/libspeechd.h

	dodoc AUTHORS ChangeLog NEWS TODO
	newinitd "${FILESDIR}"/speech-dispatcher speech-dispatcher
}

pkg_postinst() {
	if ! use espeak; then
		ewarn
		ewarn "You have disabled espeak, which is speech-dispatcher's"
		ewarn "default speech synthesizer."
		ewarn "You must edit ${EROOT}etc/speechd/speechd.conf"
	fi
	elog
	elog "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
}
