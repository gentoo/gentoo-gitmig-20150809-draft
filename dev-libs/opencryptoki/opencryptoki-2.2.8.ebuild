# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opencryptoki/opencryptoki-2.2.8.ebuild,v 1.1 2009/06/28 10:48:58 arfrever Exp $

EAPI="2"

inherit autotools eutils multilib

DESCRIPTION="PKCS#11 provider for IBM cryptographic hardware"
HOMEPAGE="http://sourceforge.net/projects/opencryptoki"
SRC_URI="mirror://sourceforge/opencryptoki/${P}.tar.bz2
		 mirror://gentoo/opencryptoki-tpm_stdll-sw_fallback-June012006.patch.bz2"
LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tpmtok"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup pkcs11
}

src_prepare() {
	sed -i '/groupadd/d' usr/lib/pkcs11/api/Makefile.am
	sed -i 's|$(DESTDIR)||' usr/include/pkcs11/Makefile.am

	# Enable fallback operation mode for imported keys.
	# Patch written by Kent Yoder.
	epatch "${WORKDIR}/opencryptoki-tpm_stdll-sw_fallback-June012006.patch"
	epatch "${FILESDIR}/opencryptoki-2.2.4.1-tpm_util.c.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable tpmtok)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	newinitd "${FILESDIR}/pkcsslotd.init" pkcsslotd

	# No need for this.
	rm -rf "${D}/etc/ld.so.conf.d"

	# tpmtoken_* binaries expect to find the libraries in /usr/lib/.
	dosym opencryptoki/stdll/libpkcs11_sw.so.0.0.0 "/usr/$(get_libdir)/libpkcs11_sw.so"
	dosym opencryptoki/stdll/libpkcs11_tpm.so.0.0.0 "/usr/$(get_libdir)/libpkcs11_tpm.so"

	dodoc doc/openCryptoki-HOWTO.pdf
}
