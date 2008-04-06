# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mktemp/pam_mktemp-1.0.3.ebuild,v 1.8 2008/04/06 23:16:41 josejx Exp $

inherit toolchain-funcs pam

DESCRIPTION="Create per-user private temporary directories during login"
HOMEPAGE="http://www.openwall.com/pam/"
SRC_URI="http://www.openwall.com/pam/modules/${PN}/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -fPIC" \
		LDFLAGS="${LDFLAGS} --shared -Wl,--version-script,\$(MAP)" \
		|| die "emake failed"
}

src_install() {
	dopammod pam_mktemp.so
	dodoc README
}

pkg_postinst() {
	elog "To enable pam_mktemp put something like"
	elog
	elog "session    optional    pam_mktemp.so"
	elog
	elog "into /etc/pam.d/system-auth!"
}
