/***************************************************************************
	  	                        vfs.cpp
  	                    -------------------
    Version							 : Milestone 1
    begin                : Thu May 4 2000
    copyright            : (C) 2000 by Shie Erlich & Rafi Yanai
 *-------------------------------------------------------------------------*
 * the vfs class is an extendable class which by itself does (almost)      *
 * nothing. other VFSs like the normal_vfs inherits from this class and    *
 * make it possible to use a consistent API for all types of VFSs.         *
 *                                                                         *
 ***************************************************************************

   A

     db   dD d8888b. db    db .d8888.  .d8b.  d8888b. d88888b d8888b.
     88 ,8P' 88  `8D 88    88 88'  YP d8' `8b 88  `8D 88'     88  `8D
     88,8P   88oobY' 88    88 `8bo.   88ooo88 88   88 88ooooo 88oobY'
     88`8b   88`8b   88    88   `Y8b. 88~~~88 88   88 88~~~~~ 88`8b
     88 `88. 88 `88. 88b  d88 db   8D 88   88 88  .8D 88.     88 `88.
     YP   YD 88   YD ~Y8888P' `8888Y' YP   YP Y8888D' Y88888P 88   YD

                                                     S o u r c e    F i l e

 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include "vfs.h"
#include <time.h>

void vfs::vfs_addToList(vfile *data){
	vfs_filesP->append(data);
}

// this function assumes no 2 identical elements exist in the list
void vfs::vfs_removeFromList(vfile *data) {
	vfs_filesP->remove(data);
}

long vfs::vfs_totalSize(){
	long temp=0;
	class vfile* vf=vfs_getFirstFile();
		
	while (vf!=0){
		if ( (vf->vfile_getName() != ".") && ( vf->vfile_getName() != "..")
		     && !(vf->vfile_isDir()) )
				temp+=vf->vfile_getSize();
		vf=vfs_getNextFile();
	}
	return temp;
}

vfile* vfs::vfs_search(QString name){	
	vfile* temp = vfs_getFirstFile();
		
	while (temp!=0){
		if (temp->vfile_getName()==name) return temp;
		temp=vfs_getNextFile();
	}
	return 0;
}

static QString round(int i){
	QString t;
	t.sprintf("%d",i);
	if(i<10) t=("0"+t);
	return t;
}

// create a easy to read date-time format
QString vfs::dateTime2QString(const QDateTime& datetime){
	QString dateTime;
	QDate date = datetime.date();
	QTime time = datetime.time();
	
	// construct the string
	dateTime=round(date.day())+"/"+round(date.month())+
	        "/"+round(date.year()%100)+
		     +" "+round(time.hour())+":"+round(time.minute());
	return dateTime;
}

// create a easy to read date-time format
QString vfs::time2QString(long time){
	QString dateTime;
	// convert the time_t to struct tm
	struct tm* t=localtime(&time);
	
	// construct the string
	dateTime=round(t->tm_mday)+"/"+round(t->tm_mon+1)+"/"+round(t->tm_year%100)+
		     +" "+round(t->tm_hour)+":"+round(t->tm_min);
	return dateTime;
}


QString vfs::mode2QString(mode_t m){
	QString perm ="----------";
	
	if( S_ISLNK(m) ) perm[0]='l';  // check for symLink	
  if( S_ISDIR(m) )  perm[0]='d';  // check for directory
	
	//ReadUser = 0400, WriteUser = 0200, ExeUser = 0100
	if(m&0400) perm[1]='r';
	if(m&0200) perm[2]='w';
	if(m&0100) perm[3]='x';
	//ReadGroup = 0040, WriteGroup = 0020, ExeGroup = 0010
	if(m&0040) perm[4]='r';
	if(m&0020) perm[5]='w';
	if(m&0010) perm[6]='x';	
	//ReadOther = 0004, WriteOther = 0002, ExeOther = 0001
	if(m&0004) perm[7]='r';
	if(m&0002) perm[8]='w';
	if(m&0001) perm[9]='x';

	return perm;
}
