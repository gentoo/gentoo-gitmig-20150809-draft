#Copyright 2000 Achim Gottinger
 
P=portage-1.0
A=""
S=${WORKDIR}/${P}
CATEGORY="sys"
DESCRIPTION="Portage autobuild system"

src_unpack() {
  mkdir ${S}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${FILESDIR}
  insinto /etc
  doins make.conf
  dodir /usr/bin
  dodir /usr/sbin
  insinto /usr/bin
  insopts -m755
  doins ebuild *.sh
  insinto /usr/sbin
  doins merge.py unmerge.py
}




