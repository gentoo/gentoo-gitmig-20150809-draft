# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.2.ebuild,v 1.5 2002/08/01 11:59:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Embeddable Common Lisp 'Spain'"
SRC_URI="mirror://sourceforge/ecls/${P}.tgz"

PROVIDE="virtual/commonlisp"

#src_unpack() {
#
#    unpack ${P}.tgz
#
#    mv ${WORKDIR}/ecls-0.2 ${S}
#}

src_compile() {

    local myconf

    if [ "`use X`" ]
    then
        myopts="${myconf} --with-x"
    else
        myopts="${myconf} --with-x=no"
    fi

    echo ${CXXFLAGS} ${CFLAGS} ${LSPCFLAGS}
    try ./configure --prefix=/usr $myopts

    #
    # FIXME: This really needs to be triple-verified
    #
    local mcpu=`echo ${CFLAGS} | sed "s/.*-mcpu=\([a-zA-Z0-9]*\).*/\1/g"`
    local march=`echo ${CFLAGS} | sed "s/.*-march=\([a-zA-Z0-9]*\).*/\1/g"`

    echo ${mcpu} -- ${march}

    for i in build/{crs,c,gc,tk,.}/Makefile ; do 
       cp $i $i.orig ;
       cat $i.orig | sed -e "s:-mcpu= 1:-mcpu=${mcpu}:g" | sed -e "s:-march= 1:-march=${march}:g" > $i ;
    done

    cp build/gabriel/Makefile build/gabriel/Makefile.orig
    cat build/gabriel/Makefile.orig | sed "s/FILES =.*/FILES = ECLSc ECLSi/g" > build/gabriel/Makefile

    touch LGPL

    alias lisp='echo NOT INSTALLED!' 
    echo ${CXXFLAGS} ${CFLAGS}
    try make

}

src_install() {
    try make install PREFIX=${D}/usr
}
