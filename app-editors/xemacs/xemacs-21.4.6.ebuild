# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Geert Bevin <gbevin@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.4.5.ebuild,v 1.2 2001/12/13 20:28:19 gbevin Exp

S="${WORKDIR}/${P}"
DESCRIPTION="The ultimate emacs, IMO.  This is a non-FSF but still free for use version of the biggest text editor ever created."
EFS=1.27
BASE=1.58
DEPEND="sys-libs/ncurses
        nas? ( media-libs/nas )
        esd? ( media-sound/esound )
        >=sys-libs/db-3
        motif? ( >=x11-libs/openmotif-2.1.30 )
        X? ( virtual/x11
             media-libs/libpng
             media-libs/tiff
             media-libs/jpeg
             media-libs/compface )"
SRC_URI="http://ftp.us.xemacs.org/ftp/pub/xemacs/xemacs-21.4/${P}.tar.gz
         http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/efs-${EFS}-pkg.tar.gz
         http://ftp.us.xemacs.org/ftp/pub/xemacs/packages/xemacs-base-${BASE}-pkg.tar.gz"
HOMEPAGE="http://www.xemacs.org"

src_unpack() {
        cd "${WORKDIR}"
        unpack "${P}.tar.gz"
}

src_compile() {                           
        local myopts
        local soundopts
        
        if [ "`use X`" ]
        then
                myopts="--with-x --with-jpeg --with-png --with-tiff --with-xface
                        --with-menubars=lucid --with-scrollbars=lucid"
                if [ "`use motif`" ]
                then
                        myopts="$myopts --with-dialogs=motif --with-widgets=motif"
                else
                        myopts="$myopts --with-dialogs=lucid --with-widgets=lucid"
                fi
        else
                myopts="--without-x"
        fi
        
        if [ "`use gpm`" ]
        then
                myopts="$myopts --with-gpm"
        else
                myopts="$myopts --without-gpm"
        fi
        
        soundopts="native"
        if [ "`use nas`" ]
        then
                soundopts="$soundopts,nas"
        fi
        if [ "`use esd`" ]
        then
                soundopts="$soundopts,esd"
        fi
        myopts="$myopts --with-sound=$soundopts"

        ./configure $myopts \
                --with-database=gnudbm \
                --prefix=/usr \
                --with-ncurses \
                --with-pop \
                --without-dragndrop \
                --with-xpm \
                --with-gif=no \
                --with-site-lisp=yes \
                --package-path=/usr/lib/xemacs/xemacs-packages/ \
                || die
        emake || die
}

src_install() {                               
        make prefix="${D}/usr" \
                mandir="${D}/usr/share/man/man1" \
                infodir="${D}/usr/share/info" \
                install || die
        
        # Install the two packages
        dodir /usr/lib/xemacs/xemacs-packages/
        cd "${D}/usr/lib/xemacs/xemacs-packages/"
        unpack "efs-${EFS}-pkg.tar.gz"
        unpack "xemacs-base-${BASE}-pkg.tar.gz"
        
        #remove extraneous files
        cd "${D}/usr/share/info"
        rm -f dir info.info texinfo* termcap*
        cd "${S}"
        dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}
