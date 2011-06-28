# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/plymouth/plymouth-0.8.3-r4.ebuild,v 1.1 2011/06/28 18:54:43 aidecoe Exp $

EAPI="3"

inherit autotools-utils

PLGN="plymouth-openrc-plugin"
PLGV="0.1.1"
PLG="${PLGN}-${PLGV}"

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.bz2
	http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/gentoo-logo.png
	http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/${PLG}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_intel video_cards_nouveau video_cards_radeon"
IUSE="${IUSE_VIDEO_CARDS} +branding gdm +pango static-libs"

DEPEND=">=media-libs/libpng-1.2.16
	>=x11-libs/gtk+-2.12:2
	>=sys-apps/openrc-0.8.2-r1
	pango? ( >=x11-libs/pango-1.21 )
	video_cards_intel? ( x11-libs/libdrm[video_cards_intel] )
	video_cards_nouveau? ( x11-libs/libdrm[video_cards_nouveau] )
	video_cards_radeon? ( x11-libs/libdrm[video_cards_radeon] )
	"
RDEPEND="${DEPEND}
	>=sys-kernel/dracut-008-r1[dracut_modules_plymouth]
	"

DOCS=(AUTHORS ChangeLog NEWS README TODO)

PATCHES=(
	"${FILESDIR}"/${PV}-drm-reduce-minimum-build-requirements.patch
	"${FILESDIR}"/${PV}-image-replace-deprecated-libpng-function.patch
	"${FILESDIR}"/${PV}-gentoo-fb-path.patch
	)

SP="${WORKDIR}/${PLG}"

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
		$(use_enable pango)
		$(use_enable gdm gdm-transition)
		$(use_enable video_cards_intel libdrm_intel)
		$(use_enable video_cards_nouveau libdrm_nouveau)
		$(use_enable video_cards_radeon libdrm_radeon)
		)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

	cd "${SP}"
	emake || die 'emake'
}

src_install() {
	autotools-utils_src_install

	if use static-libs; then
		mv "${D}/$(get_libdir)"/libply{,-splash-core}.{a,la} \
			"${D}/usr/$(get_libdir)"/ || die 'mv *.{a,la} files failed'
		gen_usr_ldscript libply.so libply-splash-core.so
	else
		einfo "Removing /usr/$(get_libdir)/plymouth/*.la"
		rm "${D}/usr/$(get_libdir)"/plymouth/{*.la,renderers/*.la} \
			|| die 'rm *.la'
	fi

	if use branding ; then
		insinto /usr/share/plymouth
		newins "${DISTDIR}"/gentoo-logo.png bizcom.png || die 'branding failed'
	fi

	cd "${SP}"
	insinto /$(get_libdir)/rc/plugins
	doins plymouth.so
}

pkg_postinst() {
	elog "Follow instructions on"
	elog ""
	elog "  http://dev.gentoo.org/~aidecoe/doc/en/plymouth.xml"
	elog ""
	elog "to setup Plymouth."
	echo
	ewarn "You need to disable 'interactive' feature in /etc/rc.conf to make"
	ewarn "Plymouth work properly with init system."

	if [[ ! -w /run ]]; then
		eerror "You need to create /run directory.  It's required by Plymouth "
		eerror "plugin for OpenRC (and will be by Plymouth itself in the future"
		eerror "versions).  Dracut is mounting tmpfs under this directory when"
		eerror "available."
		echo
		elog "If you'd like to know more about purpose of /run, please read:"
		elog ""
		elog "  https://lwn.net/Articles/436012/"
		elog ""
	fi
}
