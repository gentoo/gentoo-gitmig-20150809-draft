# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-1.2.71.ebuild,v 1.1 2007/06/20 06:19:16 dberkholz Exp $

inherit eutils python rpm multilib toolchain-funcs

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

MY_P="${PN/lib}-${PV}"

DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="mirror://fedora/development/source/SRPMS/${MY_P}-${RPMREV}.src.rpm"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-libs/popt
	sys-apps/hwdata-redhat
	!sys-libs/libkudzu"
DEPEND="dev-libs/popt
	>=sys-apps/pciutils-2.2.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch \
		"${FILESDIR}"/1.2.52-remove-pci-device-class.patch \
		"${FILESDIR}"/${PV}-sparc-updates.patch
}

src_compile() {
	emake \
		all \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB) \
		RPM_OPT_FLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake \
		install \
		install-program \
		DESTDIR="${D}" \
		libdir="${D}/usr/$(get_libdir)" \
		CC=$(tc-getCC) \
		|| die "install failed"

	# don't install incompatible init scripts
	rm -rf \
		"${D}"/etc/rc.d \
		|| die "removing rc.d files failed"
}

pkg_postinst() {
	python_version

	python_mod_compile \
		"${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/kudzu.py
}

pkg_postrm() {
	python_mod_cleanup
}
