# Copyright 2002 moto kawasaki <kawasaki@kawasaki3.org>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/mule-ucs/mule-ucs-0.84.ebuild,v 1.2 2002/08/01 19:42:43 karltk Exp $

P="Mule-UCS-${PV}"
S=${WORKDIR}/${P}
DESCRIPTION="A character code translator."
SRC_URI="ftp://ftp.m17n.org/pub/mule/Mule-UCS/${P}.tar.gz"
HOMEPAGE="http://www.m17n.org/Mule-UCS/"
DEPEND=">=app-editors/emacs-20.4"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
#	cd ${S};

	emacs -q --no-site-file -batch -l mucs-comp.el || die
}

src_install() {

	insinto /usr/share/emacs/site-lisp/Mule-UCS-0.84/big5conv
	insopts -m0644

	doins lisp/big5conv/big5conv.el
	doins lisp/big5conv/README
	doins lisp/big5conv/big5-comp.el
	doins lisp/big5conv/big5c-cns.el
	doins lisp/big5conv/big5c-ucs.el
	doins lisp/big5conv/big5type.el

	insinto /usr/share/emacs/site-lisp/Mule-UCS-0.84
	insopts -m0644

	doins lisp/ChangeLog
	doins lisp/MuleUni.txt
	doins lisp/README
	doins lisp/README.Unicode
	doins lisp/mccl-font.el
	doins lisp/mucs-ccl.el
	doins lisp/mucs-error.el
	doins lisp/mucs-type.el
	doins lisp/mucs.el
	doins lisp/mule-uni.el
	doins lisp/tae.el
	doins lisp/tbl-mg.el
	doins lisp/trans-util.el
	doins lisp/txt-tbl.el
	doins lisp/type.txt
	doins lisp/un-data.el
	doins lisp/un-define.el
	doins lisp/un-supple.el
	doins lisp/un-tools.el
	doins lisp/un-trbase.el
	doins lisp/unicode.el
	doins lisp/unidata.el
	doins lisp/utf.el
	doins lisp/mucs.elc
	doins lisp/mucs-type.elc
	doins lisp/mucs-error.elc
	doins lisp/mucs-ccl.elc
	doins lisp/mccl-font.elc
	doins lisp/tbl-mg.elc
	doins lisp/trans-util.elc
	doins lisp/txt-tbl.elc
	doins lisp/tae.elc
	doins lisp/mule-uni.elc
	doins lisp/unicode.elc
	doins lisp/utf.elc
	doins lisp/un-data.elc
	doins lisp/un-tools.elc
	doins lisp/unidata.elc
	doins lisp/un-define.elc
	doins lisp/un-supple.elc

	insinto /usr/share/emacs/site-lisp/Mule-UCS-0.84/jisx0213
	insopts -m0644

	doins lisp/jisx0213/ChangeLog
	doins lisp/jisx0213/egg-sim-jisx0213.el
	doins lisp/jisx0213/jisx0213.el
	doins lisp/jisx0213/readme.txt
	doins lisp/jisx0213/ujisx0213.el
	doins lisp/jisx0213/x0213-cdef.el
	doins lisp/jisx0213/x0213-char.el
	doins lisp/jisx0213/x0213-comp.el
	doins lisp/jisx0213/x0213-csys.el
	doins lisp/jisx0213/x0213-font.el
	doins lisp/jisx0213/x0213-mime.el
	doins lisp/jisx0213/x0213-sjis.el
	doins lisp/jisx0213/x0213-udef.el
	doins lisp/jisx0213/x0213-util.el

	insinto /usr/share/emacs/site-lisp/Mule-UCS-0.84/reldata
	insopts -m0644

	doins lisp/reldata/u-cns-1.el
	doins lisp/reldata/u-cns-2.el
	doins lisp/reldata/u-cns-3.el
	doins lisp/reldata/u-cns-4.el
	doins lisp/reldata/u-cns-5.el
	doins lisp/reldata/u-cns-6.el
	doins lisp/reldata/u-cns-7.el
	doins lisp/reldata/uascii.el
	doins lisp/reldata/ubig5.el
	doins lisp/reldata/uethiopic.el
	doins lisp/reldata/ugb2312.el
	doins lisp/reldata/uipa.el
	doins lisp/reldata/uiscii.el
	doins lisp/reldata/uiso8859-1.el
	doins lisp/reldata/uiso8859-14.el
	doins lisp/reldata/uiso8859-15.el
	doins lisp/reldata/uiso8859-2.el
	doins lisp/reldata/uiso8859-3.el
	doins lisp/reldata/uiso8859-4.el
	doins lisp/reldata/uiso8859-5.el
	doins lisp/reldata/uiso8859-6.el
	doins lisp/reldata/uiso8859-7.el
	doins lisp/reldata/uiso8859-8.el
	doins lisp/reldata/uiso8859-9.el
	doins lisp/reldata/ujisx0201.el
	doins lisp/reldata/ujisx0208.el
	doins lisp/reldata/ujisx0212.el
	doins lisp/reldata/uksc5601.el
	doins lisp/reldata/usisheng.el
	doins lisp/reldata/usupple.el
	doins lisp/reldata/utibetan.el
	doins lisp/reldata/utis620.el
	doins lisp/reldata/uviscii.el

	insinto /usr/share/emacs/site-lisp/Mule-UCS-0.84/doc
	insopts -m0644

	doins doc/mule-ucs.sgml
	doins doc/mule-ucs.texi

}
