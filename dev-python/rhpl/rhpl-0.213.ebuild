# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rhpl/rhpl-0.213.ebuild,v 1.6 2009/12/07 13:07:23 djc Exp $

inherit eutils multilib python rpm toolchain-funcs distutils

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Library of python code used by Red Hat Linux programs"
HOMEPAGE="http://fedoraproject.org/wiki/SystemConfig"
SRC_URI="mirror://fedora-dev/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND="dev-lang/python
	!<sys-libs/libkudzu-1.2"
DEPEND="${RDEPEND}
	!s390? ( >=net-wireless/wireless-tools-28 )
	sys-devel/gettext"

src_unpack() {
	rpm_src_unpack
#	epatch "${FILESDIR}"/${PV}-use-raw-strings-for-gettext.diff

	sed -i \
		-e 's:gcc:$(CC):g' \
		"${S}"/src/Makefile
}

src_compile() {
	python_version
	emake \
		PYTHON=python${PYVER} \
		LIBDIR=$(get_libdir) \
		ARCH=${ARCH} \
		CC=$(tc-getCC) \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PYTHON=python${PYVER} \
		LIBDIR=$(get_libdir) \
		install || die "emake install failed"
}
