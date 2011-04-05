# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smolt/smolt-1.4.ebuild,v 1.3 2011/04/05 05:11:11 ulm Exp $

EAPI="2"

inherit python eutils

DESCRIPTION="The Fedora hardware profiler"
HOMEPAGE="https://fedorahosted.org/smolt/"
SRC_URI="https://fedorahosted.org/releases/s/m/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

DEPEND="dev-lang/python
	sys-devel/gettext"

RDEPEND="${DEPEND}
	sys-apps/hal
	>=dev-python/rhpl-0.213
	>=dev-python/urlgrabber-3.0.0
	>=dev-python/simplejson-1.7.1
	dev-python/dbus-python
	qt4? ( dev-python/PyQt4 )"

S="${S}/client"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4-upstream-{fix-gzip-calls,docdir}.patch
}

src_install() {
	emake install DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" \
		|| die "Install failed"

	if ! use qt4; then
		rm "${D}"/usr/bin/smoltGui \
				"${D}"/usr/share/smolt/client/{gui,smoltGui}.py \
				"${D}"/usr/share/applications/smolt.desktop \
				"${D}"/usr/share/man/man1/smoltGui.1.* \
			|| die "rm failed"
		rmdir "${D}"/usr/share/applications || die "rmdir failed"
	fi

	bzip2 -9 "${D}"/usr/share/doc/${PF}/PrivacyPolicy || die "bzip2 failed"
	dodoc ../README ../TODO || die "dodoc failed"

	newinitd "${FILESDIR}"/${PN}-init.d ${PN} || die "newinitd failed"
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

	if use qt4 && has_version "<dev-lang/python-2.5"; then
		elog "If you want to view your profile on the web from within smoltGui,"
		elog "you should have a link mozilla-firefox -> firefox in your path."
		echo
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
