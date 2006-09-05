# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-soundcard/system-config-soundcard-2.0.1.ebuild,v 1.1 2006/09/05 21:38:04 dberkholz Exp $

inherit eutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="2"

DESCRIPTION="A graphical interface for detecting and configuring soundcards"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="=dev-python/pygtk-2*
	=x11-libs/gtk+-2*
	dev-lang/python
	sys-apps/usermode
	media-sound/sox
	dev-python/rhpl
	sys-apps/kudzu
	>=media-sound/alsa-utils-1.0.11
	media-libs/alsa-lib
	>=dev-python/pycairo-1.2
	x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_unpack() {
	rpm_src_unpack
	epatch "${FILESDIR}"/${PV}-import-i18n-backendproc.patch
}

src_install() {
	emake \
		INSTROOT="${D}" \
		RPM_BUILD_ROOT="${D}" \
		install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/${PN}
}
