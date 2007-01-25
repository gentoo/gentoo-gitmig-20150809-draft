# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-cachesaver/claws-mail-cachesaver-0.10.3.ebuild,v 1.2 2007/01/25 07:54:07 opfer Exp $

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for sylpheed-claws to automatically save the cache regulary to avoid folder rebuilds in case of a crash"
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-2.6.1"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS

	# kill useless files
	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}
