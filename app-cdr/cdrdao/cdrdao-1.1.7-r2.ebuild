# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.1.7-r2.ebuild,v 1.1 2003/06/29 14:28:03 aliz Exp $

inherit flag-o-matic

IUSE="gnome oggvorbis"

S=${WORKDIR}/${P}
DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
SRC_URI="mirror://sourceforge/cdrdao/${P}.src.tar.gz"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
RDEPEND="gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
        	>=dev-cpp/gnomemm-1.2.2 )
        dev-perl/MP3-Info
        dev-perl/Audio-Wav
        dev-perl/Audio-Tools
	>=app-cdr/cdrtools-2.01_alpha16
	>=sys-apps/sed-4"

DEPEND=">=dev-util/pccts-1.33.24-r1
        ${RDEPEND}"

KEYWORDS="~x86 ~ppc ~sparc alpha"

src_unpack() {
        unpack ${A}
        cd ${S}

        epatch ${FILESDIR}/${PF}-mp32dao-gentoo.diff

        if [ ! "`use oggvorbis`" ]; then
                cd ${S}/contrib/mp32dao
                sed -i '22s/^/#/' MediaHandler.pm
        fi
}

src_compile() {
        local mygnome=""

        if [ "`use gnome`" ] ; then
                mygnome=" --with-gnome"
		append-flags $( /usr/bin/gtkmm-config --cflags ) -fno-exceptions
        fi

        # -funroll-loops do not work
        filter-flags "-funroll-loops"

        ./configure "${mygnome}" \
                --prefix=/usr \
                --build="${CHOST}"\
                --host="${CHOST}" \
		--with-scglib-inc=/usr/include/scsilib \
		--with-scglib-lib=/usr/lib

        emake || die
}

src_install() {
        # mp32dao.pl
        dobin contrib/mp32dao/mp32dao.pl
        insinto /usr/share/cdrdao/mp32dao
        doins contrib/mp32dao/MediaHandler.pm contrib/mp32dao/mp3handler.pm \
                contrib/mp32dao/BaseInfo.pm
        use oggvorbis && doins contrib/mp32dao/ogghandler.pm

        # cdrdao gets definitely installed
        # binary
        dobin dao/cdrdao

        # data of cdrdao in /usr/share/cdrdao/
        # (right now only driverlist)
        insinto /usr/share/cdrdao
        newins dao/cdrdao.drivers drivers

        # man page
        into /usr
        newman dao/cdrdao.man cdrdao.1

        # documentation
        docinto ""
        dodoc COPYING CREDITS INSTALL README* Release*


        # and now the optional GNOME frontend
        if [ "`use gnome`" ]
        then

                # binary
                into /usr
                dobin xdao/gcdmaster

                # pixmaps for gcdmaster in /usr/share/pixmaps/gcdmaster
                insinto /usr/share/pixmaps/gcdmaster
                doins xdao/*.png xdao/*.xpm

                # application links
                # gcdmaster.desktop in /usr/share/gnome/apps/Applications
                insinto /usr/share/gnome/apps/Applications
                doins xdao/gcdmaster.desktop

                # xcdrdao.1 renamed to gcdmaster.1 in /usr/share/man/man1/
                into /usr
                newman xdao/xcdrdao.man gcdmaster.1
        fi
}

