# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-cachesaver/sylpheed-claws-cachesaver-0.10.2.ebuild,v 1.2 2006/11/13 17:07:15 ticho Exp $

MY_P="${P#sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to automatically save the cache regulary to avoid folder rebuilds in case of a crash"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.5.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
