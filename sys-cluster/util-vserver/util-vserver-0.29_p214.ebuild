# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.29_p214.ebuild,v 1.1 2004/08/25 14:53:29 tantive Exp $
# 

inherit eutils

MY_P="${P/_p/.}"
DESCRIPTION="Vserver admin-tools."
#SRC_URI="http://www-user.tu-chemnitz.de/~ensc/util-vserver/${P}.tar.bz2"
SRC_URI="http://www.13thfloor.at/vserver/d_rel26/v1.9.1/${MY_P}.tar.bz2"
HOMEPAGE="http://www.13thfloor.at/vserver/ http://savannah.nongnu.org/projects/util-vserver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

## TODO: optional (though NOT recommended) depend on dietlibc?
## hmm, dietlibc-linking results in ld-errors ...
#DEPEND="dev-libs/dietlibc"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
    unpack ${A}
    cd ${S}/scripts
    # upgrade vserver-build to 0.30.190 version
    epatch  ${FILESDIR}/vserver-build-029p214.patch 
}

src_compile() {
    #./configure --prefix=/usr --disable-internal-headers || die "configure failed"
    econf || die "econf failed"
    make || die "compile failed"
}

src_install() {
    make DESTDIR=${D} install || die "install failed"
    
    ## state-dir:
    keepdir /var/run/vservers
    ## the actual vservers go there:
    keepdir /vservers
    fperms 000 /vservers
    
    dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
    
    ## remove the non-gentoo init-scripts:
    rm -r ${D}/etc/init.d
    ## ... and install gentoo'ized ones:
    exeinto /etc/init.d/
    doexe ${FILESDIR}/vprocunhide
    newexe ${FILESDIR}/vservers-init vservers
    insinto /etc/conf.d
    newins ${FILESDIR}/vservers-conf.d vservers
}

pkg_postinst() {
    einfo
    einfo "Vservers are launched/stopped with /etc/init.d/vservers"
    einfo "You might want to edit /etc/conf.d/vservers"
    einfo
    einfo "You might want to disable namespace:"
    einfo
    einfo "	touch /etc/vservers/.defaults/nonamespace"
    einfo
    einfo "And vshelper:"
    einfo
    einfo "	mkdir -p /etc/vservers/.defaults/apps/vshelper/"
    einfo "	touch /etc/vservers/.defaults/apps/vshelper/disabled"
    einfo
    ewarn
    ewarn "Legacy configuration style is *not* supported by this package."
    ewarn
}

