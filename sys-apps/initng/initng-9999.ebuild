# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-9999.ebuild,v 1.2 2005/09/21 23:39:11 vapier Exp $

ESVN_REPO_URI="http://svn.initng.thinktux.net/initng"
ESVN_PROJECT="initng"
inherit subversion

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.thinktux.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="debug"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	./autogen.sh || die "autogen failed"
	sed -i \
		-e '/CFLAGS=.*ALL_CFLAGS/s|.*|:;|' \
		configure || die "sed configure"
}

src_compile() {
	econf \
		--prefix=/ \
		$(use_enable debug) \
		--with-doc-dir=/usr/share/doc/${PF} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README FAQ AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO
}

pkg_postinst() {
	einfo "remember to add init=/sbin/initng in your grub or lilo config"
	einfo "to use initng Happy testing."
}
