# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-641b.ebuild,v 1.2 2002/01/23 20:06:16 karltk Exp $

# notes/todo:
# 0. this is not complete. src_install is missing.
# 1. sort out g++-2 symlink. configure requires a symlink /usr/include/g++-2 -> 
# /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include. see also the configure
# parameter --with-gcc-home, which apparently doesn't work.
# 2. once it builds, research installation methods. can we install it directly,
# or do we have to generate setup sets?
# 2. get it to use as many system libs as possible. specifically stlport.
# the less it builds on its own the better. I've made an STLport-4.0 ebuild
# which installs into /usr/lib/STLport-4.0 (the current STLport-4.5 ebuild
# installs into /usr directly, and is uncompatible with 4.0). the configure
# script won't recognize it though.
# 3. figure out what to do with multi-language stuff (configure option
# --with-lang) - do we always build support for all languages?
# 4. java - blackdown? ask kabau, jdk - see if versions >1.3.1 are ok
# 5. add download mirrors to SRC_URI. in fact i'm not even sure this one works.

S=${WORKDIR}/oo_641_src

DESCRIPTION="OpenOffice productivity suite"

SRC_URI="http://a2012.g.akamai.net/7/2012/2064/OpenOffice6C/anoncvs.openoffice.org/download/oo_641_src.tar.bz2
	 ftp://ftp.cs.man.ac.uk/pub/toby/gpc/gpc231.tar.Z"

HOMEPAGE="http://www.openoffice.org"

COMMONDEPEND=">=sys-libs/glibc-2.1
	    >=sys-devel/perl-5
            virtual/x11
    	    app-shells/tcsh
    	    app-arch/zip
    	    >=media-libs/nas-1.4.1
    	    >=dev-libs/expat-1.95.1
    	    media-libs/jpeg
    	    media-gfx/sane-frontends
    	    sys-libs/zlib
	    ~dev-libs/STLport-4.0
	    java? ( ~dev-lang/jdk-1.3.1 )"

#DEPEND="$COMMONDEPEND >=sys-devel/gcc-2.95.2"
#RDEPEND=$COMMONDEPEND

src_unpack() {

    cd ${WORKDIR}
    unpack ${A}
    cd ${WORKDIR}/gpc231
    cp gpc.* ${S}/external/gpc

}

src_compile() {

    local myconf
    use java && myconf="${myconf} --with-jdk-home=${JAVA_HOME}"
    
    cd ${S}/config_office
    ./configure --with-perl-home=/usr \
		--with-stlport4-home=/usr/libs/STLport-4.0/include \
                --with-lang=ALL --with-x \
		${myconf} || die
    
    # openoffice must be compiled from csh. So I've written a #!/bin/tcsh
    # script which we execute here.
    cd ${S}
    cp ${FILESDIR}/${PV}/script-compile .
    chmod o+x ./script-compile
    export LS_COLORS=""
    ./script-compile || die
    
}


