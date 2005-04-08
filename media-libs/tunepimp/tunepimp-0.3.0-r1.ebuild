# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.3.0-r1.ebuild,v 1.6 2005/04/08 19:32:34 corsair Exp $

inherit eutils distutils perl-module

DESCRIPTION="Client library to create MusicBrainz enabled tagging applications"
HOMEPAGE="http://www.musicbrainz.org/products/tunepimp"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc x86"
IUSE="flac mad oggvorbis readline python perl"

RDEPEND=">=media-libs/musicbrainz-2.1.0
	flac? ( media-libs/flac )
	oggvorbis? ( media-libs/libvorbis )
	readline? ( sys-libs/readline )
	mad? ( media-libs/libmad )
	!media-sound/trm"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/lib${P}

src_compile() {
	# do not try to link against obsolete libtermcap
	sed -i -e 's,-ltermcap,-lncurses,' configure

	epatch ${FILESDIR}/thread.patch
	econf || die "configure failed"
	emake || die "emake failed"
	if use perl; then
		cd ${S}/perl/tunepimp-perl
		perl-module_src_compile || die "perl module failed to compile"
	fi
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	if use python; then
		cd ${S}/python
		distutils_src_install
		insinto /usr/share/doc/${PF}/examples/
		doins examples/*
	fi
	if use perl; then
		cd ${S}/perl/tunepimp-perl
		perl-module_src_install || die "perl module failed to install"
		insinto /usr/share/doc/${PF}/examples/
		doins examples/*
	fi
}
