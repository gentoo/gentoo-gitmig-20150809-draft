# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smolt/smolt-1.2.ebuild,v 1.5 2011/04/05 05:11:11 ulm Exp $

inherit python eutils

DESCRIPTION="The Fedora hardware profiler"
HOMEPAGE="https://fedorahosted.org/smolt/"
SRC_URI="https://fedorahosted.org/releases/s/m/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="dev-lang/python
	sys-devel/gettext
	gtk? ( >=dev-python/pygtk-2.10.3 )"

RDEPEND="${DEPEND}
	sys-apps/hal
	>=dev-python/rhpl-0.213
	>=dev-python/urlgrabber-3.0.0
	>=dev-python/simplejson-1.7.1
	dev-python/dbus-python"

S="${S}/client"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-config.py-gentoo-config.patch"
	epatch "${FILESDIR}/${P}-Makefile-fix-install.patch"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	insinto /usr/share/smolt/client/
	doins os_detect.py

	dosym /etc/smolt/config.py /usr/share/smolt/client/config.py
	domenu smolt.desktop

	if ! use gtk; then
		rm "${D}"/usr/bin/smoltGui
		rm "${D}"/usr/share/smolt/client/smoltGui.py
		rm "${D}"/usr/share/smolt/client/gui.py
	fi

	doman man/smolt{SendProfile,DeleteProfile}.1
	use gtk && doman man/smoltGui.1

	dodoc ../README ../TODO ../doc/PrivacyPolicy
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

	if ! [ -f "${ROOT}"/etc/smolt/hw-uuid ]; then
		elog "Creating this machines UUID in ${ROOT}/etc/smolt/hw-uuid"
		cat /proc/sys/kernel/random/uuid > "${ROOT}"/etc/smolt/hw-uuid
		UUID=$(cat "${ROOT}"/etc/smolt/hw-uuid)
		elog "Your UUID is: ${UUID}"
	fi
	echo
	elog "Call smoltSendProfile as root in order to initialize your profile."
	echo
	elog "You can withdraw it from the server if you wish to with"
	elog "   smoltDeleteProfile any time later on."
	echo

	if use gtk && has_version "<dev-lang/python-2.5"; then
		elog "If you want to view your profile on the web from within smoltGui,"
		elog "you should have a link mozilla-firefox -> firefox in your path."
		echo
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
