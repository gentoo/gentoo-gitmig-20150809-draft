# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-9999.ebuild,v 1.8 2006/02/27 00:47:53 vapier Exp $

ESVN_REPO_URI="http://svn.initng.thinktux.net/initng/trunk"
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
	emake -f Makefile.cvs || die "autogen failed"
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
	# Dont need libtool linker scripts, so punt em
	find "${D}" -name '*.la' -exec rm {} \;
	# other packages install these
	rm "${D}"/sbin/{{ifplugd,wpa_cli}.action} || die
	dodoc README FAQ AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO
}

pkg_postinst() {
	einfo "remember to add init=/sbin/initng in your grub or lilo config"
	einfo "to use initng Happy testing."
}
