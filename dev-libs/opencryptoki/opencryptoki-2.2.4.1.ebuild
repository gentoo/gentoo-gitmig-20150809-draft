# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opencryptoki/opencryptoki-2.2.4.1.ebuild,v 1.1 2007/03/25 18:09:47 kaiowas Exp $

inherit autotools eutils

DESCRIPTION="PKCS#11 provider for IBM cryptographic hardware"
HOMEPAGE="http://sourceforge.net/projects/opencryptoki"
SRC_URI="mirror://sourceforge/opencryptoki/${P}.tar.bz2
		 mirror://gentoo/opencryptoki-tpm_stdll-sw_fallback-June012006.patch.bz2"
LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="~x86"
IUSE="tpmtok"

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/groupadd/d' ${S}/usr/lib/pkcs11/api/Makefile.am
	sed -i 's|$(DESTDIR)||' ${S}/usr/include/pkcs11/Makefile.am

	# enable fallback operation mode for imported keys
	# patch written by Kent Yoder
	epatch "${WORKDIR}/opencryptoki-tpm_stdll-sw_fallback-June012006.patch" || die

	epatch "${FILESDIR}/opencryptoki-2.2.4.1-tpm_util.c.patch" || die

	eautoreconf
}

src_compile() {
	econf `use_enable tpmtok` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	newinitd "${FILESDIR}/pkcsslotd.init" pkcsslotd

	# no need for this
	rm -rf "${D}/etc/ld.so.conf.d"

	# tpmtoken_* binaries expect to find the libs in /usr/lib/
	ln -s pkcs11/stdll/libpkcs11_sw.so.0.0.0 "${D}/usr/lib/libpkcs11_sw.so"
	ln -s pkcs11/stdll/libpkcs11_tpm.so.0.0.0 "${D}/usr/lib/libpkcs11_tpm.so"

	# we have no man pages so at least these should be installed
	dodoc doc/openCryptoki-HOWTO.pdf
	dodoc doc/opencryptoki_man.txt
	dodoc doc/pk_config_data_man.txt
	dodoc doc/pkcs11_startup_man.txt
	dodoc doc/pkcsconf_man.txt
	dodoc doc/pkcsslotd_man.txt
}

pkg_setup() {
	enewgroup pkcs11
}

