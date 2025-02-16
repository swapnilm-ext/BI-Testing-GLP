USE [shipping]
GO
/****** Object:  User [swapnil]    Script Date: 24-11-2016 14:41:13 ******/
CREATE USER [swapnil] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[GetTableColumns]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetTableColumns] 
( 
@TableName varchar(max) 
) 
as 
Begin 
Select 
--tbl.* 
FK_Column,ORDINAL_POSITION,COUNT(*) as Count 
from (SELECT K_Table = FK.TABLE_NAME, 
FK_Column = CU.COLUMN_NAME, 
PK_Table = PK.TABLE_NAME, 
PK_Column = PT.COLUMN_NAME, 
Constraint_Name = C.CONSTRAINT_NAME, 
col.ORDINAL_POSITION 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C 
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.COLUMNS col on CU.COLUMN_NAME = col.COLUMN_NAME 
INNER JOIN 
( SELECT i1.TABLE_NAME, 
i2.COLUMN_NAME 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2 ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME 
WHERE i1.CONSTRAINT_TYPE = 'PRIMARY KEY' ) PT ON PT.TABLE_NAME = PK.TABLE_NAME 
union 

Select TABLE_NAME as TABLE_NAME, COLUMN_NAME as FK_Column, 
Null as PK_Table , Null as PK_Column,Null as CONSTRAINT_NAME,information_schema.columns.ORDINAL_POSITION from information_schema.columns 
) tbl 

where K_Table = @TableName and ORDINAL_POSITION <> 1 
group by FK_Column,ORDINAL_POSITION 


End; 



GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsDeleteBy_Id_Sp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsDeleteBy_Id_Sp
--This stored procedure is Intended to Delete recoeds from tbl_studentsBy ID
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsDeleteBy_Id_Sp]
( 
  @Id int = null ,
  @Issuccess int = null  output
)
as
BEGIN TRY
  Begin Transaction
   DELETE FROM tbl_students
Where Id = @Id

   set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsDeleteSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsDeleteSp
--This stored procedure is Intended to Delete recoeds from tbl_students
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsDeleteSp]
( 
  @Issuccess int = null
)
as
BEGIN TRY
  Begin Transaction
   DELETE FROM tbl_students
   set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsInsertSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsInserteSp
--This stored procedure is Intended to Insert recoeds Into tbl_students
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsInsertSp]
(
    @Name  varchar(max)=NULL,
    @Issuccess int = null OUTPUT
)
as
BEGIN TRY
  Begin Transaction
    Insert into tbl_students
      (
        Name
      )
      Values
      (
        @Name
      )
  Commit Transaction
END TRY
BEGIN Catch
 --If @@Transcount > 0
  RollBack Transaction
  set @Issuccess =0
 END Catch

GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsSelectAllSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsSelectAllSp
--This stored procedure is Intended to Select All records From tbl_students
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsSelectAllSp]
( 
  @Issuccess int = null
)
as
BEGIN TRY
  Begin Transaction
     SELECT
       Id,
       Name
     From
     tbl_students

  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsSelectBy_IdSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsSelectBy_IdSp
--This stored procedure is Intended to select record fromtbl_studentsBY Id
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsSelectBy_IdSp]
( 
  @Id int = null,
  @Issuccess int = null  output
)
as
BEGIN TRY
  Begin Transaction
     SELECT
       Id,
       Name
     From
     tbl_students
        Where Id = @Id

  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[tbl_studentsUpdateSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -tbl_studentsUpdateSp
--This stored procedure is Intended to update recoeds from tbl_students
--------------------------------------------------
Create Procedure [dbo].[tbl_studentsUpdateSp]
( 
    @Id  int=NULL,
    @Name  varchar(max)=NULL,
    @Issuccess int = NULL
)
as
BEGIN TRY
  Begin Transaction
     Update tbl_students
  Set
      Name=@Name
    where Id=@Id
  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselDeleteBy_Id_Sp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselDeleteBy_Id_Sp
--This stored procedure is Intended to Delete recoeds from vesselBy ID
--------------------------------------------------
Create Procedure [dbo].[vesselDeleteBy_Id_Sp]
( 
  @Id int = null ,
  @Issuccess int = null  output
)
as
BEGIN TRY
  Begin Transaction
   DELETE FROM vessel
Where Id = @Id

   set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselDeleteSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselDeleteSp
--This stored procedure is Intended to Delete recoeds from vessel
--------------------------------------------------
Create Procedure [dbo].[vesselDeleteSp]
( 
  @Issuccess int = null
)
as
BEGIN TRY
  Begin Transaction
   DELETE FROM vessel
   set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselInsertSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselInserteSp
--This stored procedure is Intended to Insert recoeds Into vessel
--------------------------------------------------
Create Procedure [dbo].[vesselInsertSp]
(
    @Name  varchar(max)=NULL,
    @IMO  varchar(max)=NULL,
    @MMSI  varchar(max)=NULL,
    @Call_Sign  varchar(max)=NULL,
    @Flag  varchar(max)=NULL,
    @AIS_Type  varchar(max)=NULL,
    @Gross_Tonnage  varchar(max)=NULL,
    @Deadweight  varchar(max)=NULL,
    @Length_Breadth  varchar(max)=NULL,
    @Year_Built  varchar(max)=NULL,
    @Status  varchar(max)=NULL,
    @Issuccess int = null OUTPUT
)
as
BEGIN TRY
  Begin Transaction
    Insert into vessel
      (
        Name,
        IMO,
        MMSI,
        Call_Sign,
        Flag,
        AIS_Type,
        Gross_Tonnage,
        Deadweight,
        Length_Breadth,
        Year_Built,
        Status
      )
      Values
      (
        @Name,
        @IMO,
        @MMSI,
        @Call_Sign,
        @Flag,
        @AIS_Type,
        @Gross_Tonnage,
        @Deadweight,
        @Length_Breadth,
        @Year_Built,
        @Status
      )
  Commit Transaction
END TRY
BEGIN Catch
 --If @@Transcount > 0
  RollBack Transaction
  set @Issuccess =0
 END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselSelectAllSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselSelectAllSp
--This stored procedure is Intended to Select All records From vessel
--------------------------------------------------
CREATE Procedure [dbo].[vesselSelectAllSp]
( 
  @Issuccess int = null
)
as
BEGIN TRY
  Begin Transaction
     SELECT
       Id,
       Name,
       IMO,
       MMSI,
       Call_Sign,
       Flag,
       AIS_Type,
       Gross_Tonnage,
       Deadweight,
       Length_Breadth,
       Year_Built,
       Status
     From
     vessel
	 --SELECT
  --     1 as Id,
  --     2 as Name,
  --     3 as IMO,
  --     4 as MMSI,
  --     5 as Call_Sign,
  --     6 as Flag,
  --     7 as AIS_Type,
  --     8 as Gross_Tonnage,
  --     9 as Deadweight,
  --     10 as Length_Breadth,
  --     11 as Year_Built,
  --     12 as Status
     --From
     --vessel
  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselSelectBy_IdSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselSelectBy_IdSp
--This stored procedure is Intended to select record fromvesselBY Id
--------------------------------------------------
Create Procedure [dbo].[vesselSelectBy_IdSp]
( 
  @Id int = null,
  @Issuccess int = null  output
)
as
BEGIN TRY
  Begin Transaction
     SELECT
       Id,
       Name,
       IMO,
       MMSI,
       Call_Sign,
       Flag,
       AIS_Type,
       Gross_Tonnage,
       Deadweight,
       Length_Breadth,
       Year_Built,
       Status
     From
     vessel
        Where Id = @Id

  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  StoredProcedure [dbo].[vesselUpdateSp]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------
--Author - swapnil
--Stored Procedure Name -vesselUpdateSp
--This stored procedure is Intended to update recoeds from vessel
--------------------------------------------------
Create Procedure [dbo].[vesselUpdateSp]
( 
    @Id  int=NULL,
    @Name  varchar(max)=NULL,
    @IMO  varchar(max)=NULL,
    @MMSI  varchar(max)=NULL,
    @Call_Sign  varchar(max)=NULL,
    @Flag  varchar(max)=NULL,
    @AIS_Type  varchar(max)=NULL,
    @Gross_Tonnage  varchar(max)=NULL,
    @Deadweight  varchar(max)=NULL,
    @Length_Breadth  varchar(max)=NULL,
    @Year_Built  varchar(max)=NULL,
    @Status  varchar(max)=NULL,
    @Issuccess int = NULL
)
as
BEGIN TRY
  Begin Transaction
     Update vessel
  Set
      Name=@Name,
      IMO=@IMO,
      MMSI=@MMSI,
      Call_Sign=@Call_Sign,
      Flag=@Flag,
      AIS_Type=@AIS_Type,
      Gross_Tonnage=@Gross_Tonnage,
      Deadweight=@Deadweight,
      Length_Breadth=@Length_Breadth,
      Year_Built=@Year_Built,
      Status=@Status
    where Id=@Id
  set @Issuccess =1
  Commit Transaction
END TRY
BEGIN Catch
  set @Issuccess =0
END Catch

GO
/****** Object:  Table [dbo].[tbl_students]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vessel]    Script Date: 24-11-2016 14:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vessel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NULL,
	[IMO] [varchar](max) NULL,
	[MMSI] [varchar](max) NULL,
	[Call_Sign] [varchar](max) NULL,
	[Flag] [varchar](max) NULL,
	[AIS_Type] [varchar](max) NULL,
	[Gross_Tonnage] [varchar](max) NULL,
	[Deadweight] [varchar](max) NULL,
	[Length_Breadth] [varchar](max) NULL,
	[Year_Built] [varchar](max) NULL,
	[Status] [varchar](max) NULL,
 CONSTRAINT [PK_vessel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[vessel] ON 

INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (7, N'SMIT Indra95', N'MH-o195', N'MH-o195', N'MH-o195', N'MH-o195', N'MH-o195', N'MH-o195', N'MH-o195', N'123.6795', N'199595', N'acrive95')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (8, N'SMIT Indra94', N'MH-o194', N'MH-o194', N'MH-o194', N'MH-o194', N'MH-o194', N'MH-o194', N'MH-o194', N'123.6794', N'199594', N'acrive94')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (9, N'SMIT Indra93', N'MH-o193', N'MH-o193', N'MH-o193', N'MH-o193', N'MH-o193', N'MH-o193', N'MH-o193', N'123.6793', N'199593', N'acrive93')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (10, N'SMIT Indra92', N'MH-o192', N'MH-o192', N'MH-o192', N'MH-o192', N'MH-o192', N'MH-o192', N'MH-o192', N'123.6792', N'199592', N'acrive92')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (11, N'SMIT Indra91', N'MH-o191', N'MH-o191', N'MH-o191', N'MH-o191', N'MH-o191', N'MH-o191', N'MH-o191', N'123.6791', N'199591', N'acrive91')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (12, N'SMIT Indra90', N'MH-o190', N'MH-o190', N'MH-o190', N'MH-o190', N'MH-o190', N'MH-o190', N'MH-o190', N'123.6790', N'199590', N'acrive90')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (13, N'SMIT Indra89', N'MH-o189', N'MH-o189', N'MH-o189', N'MH-o189', N'MH-o189', N'MH-o189', N'MH-o189', N'123.6789', N'199589', N'acrive89')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (14, N'SMIT Indra88', N'MH-o188', N'MH-o188', N'MH-o188', N'MH-o188', N'MH-o188', N'MH-o188', N'MH-o188', N'123.6788', N'199588', N'acrive88')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (15, N'SMIT Indra87', N'MH-o187', N'MH-o187', N'MH-o187', N'MH-o187', N'MH-o187', N'MH-o187', N'MH-o187', N'123.6787', N'199587', N'acrive87')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (16, N'SMIT Indra86', N'MH-o186', N'MH-o186', N'MH-o186', N'MH-o186', N'MH-o186', N'MH-o186', N'MH-o186', N'123.6786', N'199586', N'acrive86')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (17, N'SMIT Indra85', N'MH-o185', N'MH-o185', N'MH-o185', N'MH-o185', N'MH-o185', N'MH-o185', N'MH-o185', N'123.6785', N'199585', N'acrive85')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (18, N'SMIT Indra84', N'MH-o184', N'MH-o184', N'MH-o184', N'MH-o184', N'MH-o184', N'MH-o184', N'MH-o184', N'123.6784', N'199584', N'acrive84')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (19, N'SMIT Indra83', N'MH-o183', N'MH-o183', N'MH-o183', N'MH-o183', N'MH-o183', N'MH-o183', N'MH-o183', N'123.6783', N'199583', N'acrive83')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (20, N'SMIT Indra82', N'MH-o182', N'MH-o182', N'MH-o182', N'MH-o182', N'MH-o182', N'MH-o182', N'MH-o182', N'123.6782', N'199582', N'acrive82')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (21, N'SMIT Indra81', N'MH-o181', N'MH-o181', N'MH-o181', N'MH-o181', N'MH-o181', N'MH-o181', N'MH-o181', N'123.6781', N'199581', N'acrive81')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (22, N'SMIT Indra80', N'MH-o180', N'MH-o180', N'MH-o180', N'MH-o180', N'MH-o180', N'MH-o180', N'MH-o180', N'123.6780', N'199580', N'acrive80')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (23, N'SMIT Indra79', N'MH-o179', N'MH-o179', N'MH-o179', N'MH-o179', N'MH-o179', N'MH-o179', N'MH-o179', N'123.6779', N'199579', N'acrive79')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (24, N'SMIT Indra78', N'MH-o178', N'MH-o178', N'MH-o178', N'MH-o178', N'MH-o178', N'MH-o178', N'MH-o178', N'123.6778', N'199578', N'acrive78')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (25, N'SMIT Indra77', N'MH-o177', N'MH-o177', N'MH-o177', N'MH-o177', N'MH-o177', N'MH-o177', N'MH-o177', N'123.6777', N'199577', N'acrive77')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (26, N'SMIT Indra76', N'MH-o176', N'MH-o176', N'MH-o176', N'MH-o176', N'MH-o176', N'MH-o176', N'MH-o176', N'123.6776', N'199576', N'acrive76')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (27, N'SMIT Indra75', N'MH-o175', N'MH-o175', N'MH-o175', N'MH-o175', N'MH-o175', N'MH-o175', N'MH-o175', N'123.6775', N'199575', N'acrive75')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (28, N'SMIT Indra74', N'MH-o174', N'MH-o174', N'MH-o174', N'MH-o174', N'MH-o174', N'MH-o174', N'MH-o174', N'123.6774', N'199574', N'acrive74')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (29, N'SMIT Indra73', N'MH-o173', N'MH-o173', N'MH-o173', N'MH-o173', N'MH-o173', N'MH-o173', N'MH-o173', N'123.6773', N'199573', N'acrive73')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (30, N'SMIT Indra72', N'MH-o172', N'MH-o172', N'MH-o172', N'MH-o172', N'MH-o172', N'MH-o172', N'MH-o172', N'123.6772', N'199572', N'acrive72')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (31, N'SMIT Indra71', N'MH-o171', N'MH-o171', N'MH-o171', N'MH-o171', N'MH-o171', N'MH-o171', N'MH-o171', N'123.6771', N'199571', N'acrive71')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (32, N'SMIT Indra70', N'MH-o170', N'MH-o170', N'MH-o170', N'MH-o170', N'MH-o170', N'MH-o170', N'MH-o170', N'123.6770', N'199570', N'acrive70')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (33, N'SMIT Indra69', N'MH-o169', N'MH-o169', N'MH-o169', N'MH-o169', N'MH-o169', N'MH-o169', N'MH-o169', N'123.6769', N'199569', N'acrive69')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (34, N'SMIT Indra68', N'MH-o168', N'MH-o168', N'MH-o168', N'MH-o168', N'MH-o168', N'MH-o168', N'MH-o168', N'123.6768', N'199568', N'acrive68')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (35, N'SMIT Indra67', N'MH-o167', N'MH-o167', N'MH-o167', N'MH-o167', N'MH-o167', N'MH-o167', N'MH-o167', N'123.6767', N'199567', N'acrive67')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (36, N'SMIT Indra66', N'MH-o166', N'MH-o166', N'MH-o166', N'MH-o166', N'MH-o166', N'MH-o166', N'MH-o166', N'123.6766', N'199566', N'acrive66')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (37, N'SMIT Indra65', N'MH-o165', N'MH-o165', N'MH-o165', N'MH-o165', N'MH-o165', N'MH-o165', N'MH-o165', N'123.6765', N'199565', N'acrive65')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (38, N'SMIT Indra64', N'MH-o164', N'MH-o164', N'MH-o164', N'MH-o164', N'MH-o164', N'MH-o164', N'MH-o164', N'123.6764', N'199564', N'acrive64')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (39, N'SMIT Indra63', N'MH-o163', N'MH-o163', N'MH-o163', N'MH-o163', N'MH-o163', N'MH-o163', N'MH-o163', N'123.6763', N'199563', N'acrive63')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (40, N'SMIT Indra62', N'MH-o162', N'MH-o162', N'MH-o162', N'MH-o162', N'MH-o162', N'MH-o162', N'MH-o162', N'123.6762', N'199562', N'acrive62')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (41, N'SMIT Indra61', N'MH-o161', N'MH-o161', N'MH-o161', N'MH-o161', N'MH-o161', N'MH-o161', N'MH-o161', N'123.6761', N'199561', N'acrive61')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (42, N'SMIT Indra60', N'MH-o160', N'MH-o160', N'MH-o160', N'MH-o160', N'MH-o160', N'MH-o160', N'MH-o160', N'123.6760', N'199560', N'acrive60')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (43, N'SMIT Indra59', N'MH-o159', N'MH-o159', N'MH-o159', N'MH-o159', N'MH-o159', N'MH-o159', N'MH-o159', N'123.6759', N'199559', N'acrive59')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (44, N'SMIT Indra58', N'MH-o158', N'MH-o158', N'MH-o158', N'MH-o158', N'MH-o158', N'MH-o158', N'MH-o158', N'123.6758', N'199558', N'acrive58')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (45, N'SMIT Indra57', N'MH-o157', N'MH-o157', N'MH-o157', N'MH-o157', N'MH-o157', N'MH-o157', N'MH-o157', N'123.6757', N'199557', N'acrive57')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (46, N'SMIT Indra56', N'MH-o156', N'MH-o156', N'MH-o156', N'MH-o156', N'MH-o156', N'MH-o156', N'MH-o156', N'123.6756', N'199556', N'acrive56')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (47, N'SMIT Indra55', N'MH-o155', N'MH-o155', N'MH-o155', N'MH-o155', N'MH-o155', N'MH-o155', N'MH-o155', N'123.6755', N'199555', N'acrive55')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (48, N'SMIT Indra54', N'MH-o154', N'MH-o154', N'MH-o154', N'MH-o154', N'MH-o154', N'MH-o154', N'MH-o154', N'123.6754', N'199554', N'acrive54')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (49, N'SMIT Indra53', N'MH-o153', N'MH-o153', N'MH-o153', N'MH-o153', N'MH-o153', N'MH-o153', N'MH-o153', N'123.6753', N'199553', N'acrive53')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (50, N'SMIT Indra52', N'MH-o152', N'MH-o152', N'MH-o152', N'MH-o152', N'MH-o152', N'MH-o152', N'MH-o152', N'123.6752', N'199552', N'acrive52')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (51, N'SMIT Indra51', N'MH-o151', N'MH-o151', N'MH-o151', N'MH-o151', N'MH-o151', N'MH-o151', N'MH-o151', N'123.6751', N'199551', N'acrive51')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (52, N'SMIT Indra50', N'MH-o150', N'MH-o150', N'MH-o150', N'MH-o150', N'MH-o150', N'MH-o150', N'MH-o150', N'123.6750', N'199550', N'acrive50')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (53, N'SMIT Indra49', N'MH-o149', N'MH-o149', N'MH-o149', N'MH-o149', N'MH-o149', N'MH-o149', N'MH-o149', N'123.6749', N'199549', N'acrive49')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (54, N'SMIT Indra48', N'MH-o148', N'MH-o148', N'MH-o148', N'MH-o148', N'MH-o148', N'MH-o148', N'MH-o148', N'123.6748', N'199548', N'acrive48')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (55, N'SMIT Indra47', N'MH-o147', N'MH-o147', N'MH-o147', N'MH-o147', N'MH-o147', N'MH-o147', N'MH-o147', N'123.6747', N'199547', N'acrive47')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (56, N'SMIT Indra46', N'MH-o146', N'MH-o146', N'MH-o146', N'MH-o146', N'MH-o146', N'MH-o146', N'MH-o146', N'123.6746', N'199546', N'acrive46')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (57, N'SMIT Indra45', N'MH-o145', N'MH-o145', N'MH-o145', N'MH-o145', N'MH-o145', N'MH-o145', N'MH-o145', N'123.6745', N'199545', N'acrive45')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (58, N'SMIT Indra44', N'MH-o144', N'MH-o144', N'MH-o144', N'MH-o144', N'MH-o144', N'MH-o144', N'MH-o144', N'123.6744', N'199544', N'acrive44')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (59, N'SMIT Indra43', N'MH-o143', N'MH-o143', N'MH-o143', N'MH-o143', N'MH-o143', N'MH-o143', N'MH-o143', N'123.6743', N'199543', N'acrive43')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (60, N'SMIT Indra42', N'MH-o142', N'MH-o142', N'MH-o142', N'MH-o142', N'MH-o142', N'MH-o142', N'MH-o142', N'123.6742', N'199542', N'acrive42')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (61, N'SMIT Indra41', N'MH-o141', N'MH-o141', N'MH-o141', N'MH-o141', N'MH-o141', N'MH-o141', N'MH-o141', N'123.6741', N'199541', N'acrive41')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (62, N'SMIT Indra40', N'MH-o140', N'MH-o140', N'MH-o140', N'MH-o140', N'MH-o140', N'MH-o140', N'MH-o140', N'123.6740', N'199540', N'acrive40')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (63, N'SMIT Indra39', N'MH-o139', N'MH-o139', N'MH-o139', N'MH-o139', N'MH-o139', N'MH-o139', N'MH-o139', N'123.6739', N'199539', N'acrive39')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (64, N'SMIT Indra38', N'MH-o138', N'MH-o138', N'MH-o138', N'MH-o138', N'MH-o138', N'MH-o138', N'MH-o138', N'123.6738', N'199538', N'acrive38')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (65, N'SMIT Indra37', N'MH-o137', N'MH-o137', N'MH-o137', N'MH-o137', N'MH-o137', N'MH-o137', N'MH-o137', N'123.6737', N'199537', N'acrive37')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (66, N'SMIT Indra36', N'MH-o136', N'MH-o136', N'MH-o136', N'MH-o136', N'MH-o136', N'MH-o136', N'MH-o136', N'123.6736', N'199536', N'acrive36')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (67, N'SMIT Indra35', N'MH-o135', N'MH-o135', N'MH-o135', N'MH-o135', N'MH-o135', N'MH-o135', N'MH-o135', N'123.6735', N'199535', N'acrive35')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (68, N'SMIT Indra34', N'MH-o134', N'MH-o134', N'MH-o134', N'MH-o134', N'MH-o134', N'MH-o134', N'MH-o134', N'123.6734', N'199534', N'acrive34')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (69, N'SMIT Indra33', N'MH-o133', N'MH-o133', N'MH-o133', N'MH-o133', N'MH-o133', N'MH-o133', N'MH-o133', N'123.6733', N'199533', N'acrive33')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (70, N'SMIT Indra32', N'MH-o132', N'MH-o132', N'MH-o132', N'MH-o132', N'MH-o132', N'MH-o132', N'MH-o132', N'123.6732', N'199532', N'acrive32')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (71, N'SMIT Indra31', N'MH-o131', N'MH-o131', N'MH-o131', N'MH-o131', N'MH-o131', N'MH-o131', N'MH-o131', N'123.6731', N'199531', N'acrive31')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (72, N'SMIT Indra30', N'MH-o130', N'MH-o130', N'MH-o130', N'MH-o130', N'MH-o130', N'MH-o130', N'MH-o130', N'123.6730', N'199530', N'acrive30')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (73, N'SMIT Indra29', N'MH-o129', N'MH-o129', N'MH-o129', N'MH-o129', N'MH-o129', N'MH-o129', N'MH-o129', N'123.6729', N'199529', N'acrive29')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (74, N'SMIT Indra28', N'MH-o128', N'MH-o128', N'MH-o128', N'MH-o128', N'MH-o128', N'MH-o128', N'MH-o128', N'123.6728', N'199528', N'acrive28')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (75, N'SMIT Indra27', N'MH-o127', N'MH-o127', N'MH-o127', N'MH-o127', N'MH-o127', N'MH-o127', N'MH-o127', N'123.6727', N'199527', N'acrive27')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (76, N'SMIT Indra26', N'MH-o126', N'MH-o126', N'MH-o126', N'MH-o126', N'MH-o126', N'MH-o126', N'MH-o126', N'123.6726', N'199526', N'acrive26')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (77, N'SMIT Indra25', N'MH-o125', N'MH-o125', N'MH-o125', N'MH-o125', N'MH-o125', N'MH-o125', N'MH-o125', N'123.6725', N'199525', N'acrive25')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (78, N'SMIT Indra24', N'MH-o124', N'MH-o124', N'MH-o124', N'MH-o124', N'MH-o124', N'MH-o124', N'MH-o124', N'123.6724', N'199524', N'acrive24')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (79, N'SMIT Indra23', N'MH-o123', N'MH-o123', N'MH-o123', N'MH-o123', N'MH-o123', N'MH-o123', N'MH-o123', N'123.6723', N'199523', N'acrive23')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (80, N'SMIT Indra22', N'MH-o122', N'MH-o122', N'MH-o122', N'MH-o122', N'MH-o122', N'MH-o122', N'MH-o122', N'123.6722', N'199522', N'acrive22')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (81, N'SMIT Indra21', N'MH-o121', N'MH-o121', N'MH-o121', N'MH-o121', N'MH-o121', N'MH-o121', N'MH-o121', N'123.6721', N'199521', N'acrive21')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (82, N'SMIT Indra20', N'MH-o120', N'MH-o120', N'MH-o120', N'MH-o120', N'MH-o120', N'MH-o120', N'MH-o120', N'123.6720', N'199520', N'acrive20')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (83, N'SMIT Indra19', N'MH-o119', N'MH-o119', N'MH-o119', N'MH-o119', N'MH-o119', N'MH-o119', N'MH-o119', N'123.6719', N'199519', N'acrive19')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (84, N'SMIT Indra18', N'MH-o118', N'MH-o118', N'MH-o118', N'MH-o118', N'MH-o118', N'MH-o118', N'MH-o118', N'123.6718', N'199518', N'acrive18')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (85, N'SMIT Indra17', N'MH-o117', N'MH-o117', N'MH-o117', N'MH-o117', N'MH-o117', N'MH-o117', N'MH-o117', N'123.6717', N'199517', N'acrive17')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (86, N'SMIT Indra16', N'MH-o116', N'MH-o116', N'MH-o116', N'MH-o116', N'MH-o116', N'MH-o116', N'MH-o116', N'123.6716', N'199516', N'acrive16')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (87, N'SMIT Indra15', N'MH-o115', N'MH-o115', N'MH-o115', N'MH-o115', N'MH-o115', N'MH-o115', N'MH-o115', N'123.6715', N'199515', N'acrive15')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (88, N'SMIT Indra14', N'MH-o114', N'MH-o114', N'MH-o114', N'MH-o114', N'MH-o114', N'MH-o114', N'MH-o114', N'123.6714', N'199514', N'acrive14')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (89, N'SMIT Indra13', N'MH-o113', N'MH-o113', N'MH-o113', N'MH-o113', N'MH-o113', N'MH-o113', N'MH-o113', N'123.6713', N'199513', N'acrive13')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (90, N'SMIT Indra12', N'MH-o112', N'MH-o112', N'MH-o112', N'MH-o112', N'MH-o112', N'MH-o112', N'MH-o112', N'123.6712', N'199512', N'acrive12')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (91, N'SMIT Indra11', N'MH-o111', N'MH-o111', N'MH-o111', N'MH-o111', N'MH-o111', N'MH-o111', N'MH-o111', N'123.6711', N'199511', N'acrive11')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (92, N'SMIT Indra10', N'MH-o110', N'MH-o110', N'MH-o110', N'MH-o110', N'MH-o110', N'MH-o110', N'MH-o110', N'123.6710', N'199510', N'acrive10')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (93, N'SMIT Indra9', N'MH-o19', N'MH-o19', N'MH-o19', N'MH-o19', N'MH-o19', N'MH-o19', N'MH-o19', N'123.679', N'19959', N'acrive9')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (94, N'SMIT Indra8', N'MH-o18', N'MH-o18', N'MH-o18', N'MH-o18', N'MH-o18', N'MH-o18', N'MH-o18', N'123.678', N'19958', N'acrive8')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (95, N'SMIT Indra7', N'MH-o17', N'MH-o17', N'MH-o17', N'MH-o17', N'MH-o17', N'MH-o17', N'MH-o17', N'123.677', N'19957', N'acrive7')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (96, N'SMIT Indra6', N'MH-o16', N'MH-o16', N'MH-o16', N'MH-o16', N'MH-o16', N'MH-o16', N'MH-o16', N'123.676', N'19956', N'acrive6')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (97, N'SMIT Indra5', N'MH-o15', N'MH-o15', N'MH-o15', N'MH-o15', N'MH-o15', N'MH-o15', N'MH-o15', N'123.675', N'19955', N'acrive5')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (98, N'SMIT Indra4', N'MH-o14', N'MH-o14', N'MH-o14', N'MH-o14', N'MH-o14', N'MH-o14', N'MH-o14', N'123.674', N'19954', N'acrive4')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (99, N'SMIT Indra3', N'MH-o13', N'MH-o13', N'MH-o13', N'MH-o13', N'MH-o13', N'MH-o13', N'MH-o13', N'123.673', N'19953', N'acrive3')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (100, N'SMIT Indra2', N'MH-o12', N'MH-o12', N'MH-o12', N'MH-o12', N'MH-o12', N'MH-o12', N'MH-o12', N'123.672', N'19952', N'acrive2')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (101, N'SMIT Indra1', N'MH-o11', N'MH-o11', N'MH-o11', N'MH-o11', N'MH-o11', N'MH-o11', N'MH-o11', N'123.671', N'19951', N'acrive1')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (102, N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample', N'Sample')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (103, N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1', N'Sample1')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (106, N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1')
INSERT [dbo].[vessel] ([Id], [Name], [IMO], [MMSI], [Call_Sign], [Flag], [AIS_Type], [Gross_Tonnage], [Deadweight], [Length_Breadth], [Year_Built], [Status]) VALUES (107, N'1 Edited', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1')
GO
SET IDENTITY_INSERT [dbo].[vessel] OFF
