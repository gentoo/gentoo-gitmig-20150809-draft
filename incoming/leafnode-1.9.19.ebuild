# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Ulf Grossekathoefer <ulf.grossekathoefer@uni-bielefleld.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.6 2001/08/19 00:26:21 pete Exp

S=${WORKDIR}/${P}

DESCRIPTION="NNTP server for small sites"

SRC_URI="ftp://wpxx02.toxi.uni-wuerzburg.de/pub/${P}.tar.gz"

HOMEPAGE="http://www.leafnode.org"

DEPEND="virtual/glibc"   # I hope this is correct

#RDEPEND=""

src_compile() {
  
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	emake || die
}


src_install () {
  
	#make install prefix=DESTDIR=${D} || die # this does not work correct

	#first the binarys
	dobin newsq
	fperms 755 usr/bin/newsq
	fowners news.news usr/bin/newsq
	cp nntpd leafnode

	for I in applyfilter checkgroups fetchnews leafnode texpire 
	do
		dosbin ${I}
		fperms 750 usr/sbin/${I}
		fowners news.news usr/sbin/${I}
	done
  
  	#okay, now the manpages
	doman newsq.1 applyfilter.8 fetchnews.8 checkgroups.8 leafnode.8 texpire.8
		
	#hu, we need a spooldir	
	dodir var/spool/news
	fowners news.news var/spool/news

	for I in leaf.node fail.postings message.id interessting.groups out.going
	do
		dodir var/spool/news/${I}
		fowners news.news var/spool/news/${I}
	done
	
	cd ${D}/var/spool/news/message.id/

	for a in 0 1 2 3 4 5 6 7 8 9 ; 
	do 
    		for b in 0 1 2 3 4 5 6 7 8 9 ; 
		do 
      			mkdir -p ${a}${b}0 ${a}${b}1 ${a}${b}2 \
        			 ${a}${b}3 ${a}${b}4 ${a}${b}5 \
        		 	 ${a}${b}6 ${a}${b}7 ${a}${b}8 \
        			 ${a}${b}9 ; 
      			chown news:news ${a}${b}0 ${a}${b}1 ${a}${b}2 \
        				${a}${b}3 ${a}${b}4 ${a}${b}5 \
        				${a}${b}6 ${a}${b}7 ${a}${b}8 \
        				${a}${b}9 ; 
      		done ; 
	done 
	fperms 2755 var/spool/news

	#the lockfile:
	cd ${S}
	dodir var/lock/news
	fowners news.news var/lock/news

	# the Documentation:
	dodoc README INSTALL ChangeLog COPYING CREDITS FAQ TODO 
	docinto doc_german	
	dodoc doc_german/README

	# and the config file:
	dodir etc/leafnode
	fowners news.news etc/leafnode
	fperms 0751 etc/leafnode
	insopts -o root -g news -m 0640
	insinto etc/leafnode
	doins config.example
}

