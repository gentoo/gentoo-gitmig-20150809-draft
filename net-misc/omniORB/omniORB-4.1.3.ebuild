# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/omniORB/omniORB-4.1.3.ebuild,v 1.4 2009/12/15 19:19:43 armin76 Exp $

inherit python eutils

DESCRIPTION="A robust, high-performance CORBA 2 ORB"
SRC_URI="mirror://sourceforge/omniorb/${PF}.tar.gz"
HOMEPAGE="http://omniorb.sourceforge.net/"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-lang/python
	ssl? ( >=dev-libs/openssl-0.9.6b )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-glibc-2.10.patch

	sed -i -e 's/^CXXDEBUGFLAGS.*/CXXDEBUGFLAGS = $(OPTCXXFLAGS)/' \
		-e 's/^CDEBUGFLAGS.*/CDEBUGFLAGS = $(OPTCFLAGS)/' \
		mk/beforeauto.mk.in \
		mk/platforms/i586_linux_2.0*.mk || die "sed failed"
}

src_compile() {
	mkdir build || die
	cd build

	MY_CONF="--prefix=/usr --with-omniORB-config=/etc/omniorb/omniORB.cfg \
		--with-omniNames-logdir=/var/log/omniORB --libdir=/usr/$(get_libdir)"

	use ssl && MY_CONF="${MY_CONF} --with-openssl=/usr"

	python_version
	PYTHON=/usr/bin/python${PYVER} ECONF_SOURCE=".." econf ${MY_CONF} \
		|| die "./configure failed"

	emake OPTCFLAGS="${OPTCFLAGS}" OPTCXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install () {
	cd "${S}/build"
	emake DESTDIR="${D}" install || die "emake install failed"

	cd "${S}"
	dodoc COPYING* CREDITS README* ReleaseNotes* || die

	docinto print
	dodoc doc/*.ps doc/*.pdf || die

	dodir /etc/env.d/
	cat <<- EOF > "${T}/90omniORB"
		PATH="/usr/share/omniORB/bin/scripts"
		OMNIORB_CONFIG="/etc/omniorb/omniORB.cfg"
	EOF
	doenvd "${T}/90omniORB" || die
	doinitd "${FILESDIR}"/omniNames || die

	cp "sample.cfg" "${T}/omniORB.cfg" || die
	cat <<- EOF >> "${T}/omniORB.cfg"
		# resolve the omniNames running on localhost
		InitRef = NameService=corbaname::localhost
	EOF
	dodir /etc/omniorb
	insinto /etc/omniorb
	doins "${T}/omniORB.cfg" || die

	keepdir /var/log/omniORB
}

pkg_postinst() {
	elog "Since 4.1.2, the omniORB init script has been renamed to omniNames for clarity."
	python_mod_optimize "/usr/$(get_libdir)/python${PYVER}/site-packages/omniidl"
	python_mod_optimize "/usr/$(get_libdir)/python${PYVER}/site-packages/omniidl_be"
}

pkg_postrm() {
	python_mod_cleanup
}
