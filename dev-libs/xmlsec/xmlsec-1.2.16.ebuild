# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlsec/xmlsec-1.2.16.ebuild,v 1.4 2010/06/24 15:03:53 phajdan.jr Exp $

EAPI="3"

DESCRIPTION="Command line tool for signing, verifying, encrypting and decrypting XML"
HOMEPAGE="http://www.aleksey.com/xmlsec"
SRC_URI="http://www.aleksey.com/xmlsec/download/${PN}1-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="gcrypt gnutls nss +openssl"

RDEPEND=">=dev-libs/libxml2-2.7.4
	>=dev-libs/libxslt-1.0.20
	gcrypt? ( >=dev-libs/libgcrypt-1.4.0 )
	gnutls? ( >=net-libs/gnutls-2.8.0 )
	nss? (
		>=dev-libs/nspr-4.4.1
		>=dev-libs/nss-3.9
	)
	openssl? ( >=dev-libs/openssl-0.9.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}1-${PV}"

pkg_setup() {
	if ! use gcrypt && ! use gnutls && ! use nss && ! use openssl; then
		die "At least one of the following USE flags must be enabled: gcrypt gnutls nss openssl"
	fi

	if use gnutls && ! use gcrypt; then
		die "USE=\"gnutls\" requires USE=\"gcrypt\""
	fi
}

#src_prepare() {
#	eautoreconf
#	append-cppflags '-DLTDL_OBJDIR=\".libs\"' '-DLTDL_SHLIB_EXT=\".so\"'
#}

src_configure() {
	# Redefine use_with() until fixed version is available in released versions of Portage.
	# http://git.overlays.gentoo.org/gitweb/?p=proj/portage.git;a=commit;h=a05bba76435d94407fd25549d0552902962baf62
	use_with() {
		local UW_SUFFIX=${3+=$3}
		local UWORD=${2:-$1}

		if useq $1; then
			echo "--with-${UWORD}${UW_SUFFIX}"
		else
			echo "--without-${UWORD}"
		fi
	}

	econf \
		$(use_with gcrypt gcrypt "") \
		$(use_with gnutls gnutls "") \
		$(use_with nss nspr "") \
		$(use_with nss nss "") \
		$(use_enable openssl aes) \
		$(use_with openssl openssl "") \
		--enable-pkgconfig \
		--enable-xkms \
		--with-html-dir=/usr/share/doc/${PF}
}

src_test() {
	TMPFOLDER="${T}" emake check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README NEWS || die "dodoc failed"
}
